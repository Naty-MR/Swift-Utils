//
//  RestClienteAlamofire.swift
//  Swift-Utils
//
//  Created by Natalia Martin on 21/01/2019.
//  Copyright © 2019. All rights reserved.
//

import Foundation
import Alamofire

enum Method: String {
    case POST = "POST"
    case GET = "GET"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

class RestClientAlamofire {
    
    static let baseURL = ""
    
    static func doRequest(_ method: Method,
                          to endPoint: String,
                          withParameters parameters: Dictionary<String, String>,
                          parametersAny: Dictionary<String, Any> = [:],
                          headers: Dictionary<String, String> = [:],
                          succes: @escaping (_ resonse: [String: Any]) -> Void,
                          failure: @escaping () -> Void) {
        var url = (baseURL + endPoint).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        var mutableUrl = URLRequest(url: URL(string: url)!)
        mutableUrl.addValue("application/json", forHTTPHeaderField: "Content-Type")
        mutableUrl.httpMethod = method.rawValue
        
        for (key, value) in headers {
            mutableUrl.addValue(value, forHTTPHeaderField: key)
        }
        
        if method == .GET {
            for (key, value) in parameters {
                url += (url == mutableUrl.url?.absoluteString ? "?" : "&") + key + "=" + value
            }
            mutableUrl.url = URL(string: (url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""))
        } else {
            var paramsConcat = parameters as Dictionary<String, Any>
            for key in parametersAny.keys {
                paramsConcat[key] = parametersAny[key]
            }
            mutableUrl.httpBody = try! JSONSerialization.data(withJSONObject: paramsConcat, options: [])
        }
        
        Alamofire.request(mutableUrl)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .success:
                    print(response)
                    if let jsonResponse = response.result.value as? [String: Any] {
                        succes(jsonResponse)
                        break
                    }
                    failure()
                case .failure(let error):
                    print(error)
                    failure()
                    break
                }
        }
        
    }
    
    static func authenticate(to endPoint: String,
                             user: String,
                             password: String,
                             succes: @escaping (_ resonse: [String: Any]) -> Void,
                             failure: @escaping () -> Void) {
        let url = (baseURL + endPoint).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        var mutableUrl = URLRequest(url: URL(string: url)!)
        let data = "\(user):\(password)".data(using: .utf8)
        let credential = data!.base64EncodedString(options: [])
        mutableUrl.addValue("Basic \(credential)", forHTTPHeaderField: "Authorization")
        mutableUrl.addValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        mutableUrl.httpBody = try! JSONSerialization.data(withJSONObject: ["email" : user,
                                                                           "password" : password],
                                                          options: [])
        mutableUrl.httpMethod = Method.POST.rawValue
        
        Alamofire.request(mutableUrl)
            .authenticate(user: user, password: password)
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                switch response.result {
                case .success:
                    print(response)
                    if let jsonResponse = response.result.value as? [String: Any] {
                        succes(jsonResponse)
                        break
                    }
                    failure()
                case .failure(let error):
                    print(error)
                    failure()
                    break
                }
        }
    }
}
