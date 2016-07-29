//
//  ViewController.swift
//  activityWebView
//
//  Created by Kero on 2016/5/14.
//  Copyright © 2016年 Kero. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var myWebView: UIWebView!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
       let url = NSURL(string: "http://www.apple.com")
        let request = NSURLRequest(URL:url!)
        myWebView.loadRequest(request)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func webViewDidStartLoad(webView: UIWebView) {
        myActivityIndicator.startAnimating()
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        myActivityIndicator.stopAnimating()
    }
}

