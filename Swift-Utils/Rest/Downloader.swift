//
//  Downloader.swift
//  Swift-Utils
//
//  Created by Natalia Martin on 13/7/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import Alamofire

class Downloader {
    class func load(URL url: URL, succes:  @escaping () -> Void, failure:  @escaping () -> Void) {
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            documentsURL.appendPathComponent("FileFolder/" + url.lastPathComponent)
            return (documentsURL, [.createIntermediateDirectories, .removePreviousFile])
        }

        Alamofire.download(url, to: destination).response { response in
            print(response)
             
            if 200 ... 299 ~= response.response?.statusCode ?? -1 {
                succes()
            } else {
                failure()
            }
        }
    }
}
