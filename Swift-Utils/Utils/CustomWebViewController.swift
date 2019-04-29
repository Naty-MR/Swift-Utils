//
//  CustomWebViewController.swift
//  Swift-Utils
//
//  Created by Natalia Martin on 11/12/2018.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class CustomWebViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var webView: WKWebView!
    
    var filePath: URL?
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoadingView()
        
        if url != "" {
            webView.load((NSURLRequest(url: NSURL(string: url)! as URL) as URLRequest))
        } else {
            webView.loadFileURL(filePath!, allowingReadAccessTo: filePath!)
        }
        webView.navigationDelegate = self
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideLoadingView()
    }
}
