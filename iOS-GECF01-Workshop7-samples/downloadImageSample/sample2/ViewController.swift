//
//  ViewController.swift
//  sample2
//
//  Created by Adam Lin on 2016/6/3.
//  Copyright © 2016年 AdamLin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSURLSessionDownloadDelegate  {
    
    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var busyIndicator: UIActivityIndicatorView!
    @IBOutlet weak var progressView: UIProgressView!
    
    var session:NSURLSession!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Event Handler
    @IBAction func ontaggleStartBtn(sender:UIButton) {
        
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        sessionConfiguration.timeoutIntervalForRequest = 10
        
        session = NSURLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: nil)
        
        let downloadUrl = NSURL(string: "https://dl.dropboxusercontent.com/u/23305422/testImage-10M.png")
        
        let downloadTask = session.downloadTaskWithURL(downloadUrl!)
        
        imageView.image = nil
        progressView.progress = 0
        startBtn.enabled = false
        busyIndicator.startAnimating()
        
        downloadTask.resume()
    }
    
    //MARK: NSURLSESSIONDownloadTask Delegate
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL){
        
        guard let data = NSData(contentsOfURL: location) else{
            print("Error! download data is nil")
            dispatch_async(dispatch_get_main_queue()) {
                self.startBtn.enabled = true
                self.busyIndicator.stopAnimating()
            }
            return
        }
        
        guard let image = UIImage(data: data) else{
            print("Error! generate image from data fail.")
            dispatch_async(dispatch_get_main_queue()) {
                self.startBtn.enabled = true
                self.busyIndicator.stopAnimating()
            }
            return
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            self.imageView.image = image
            self.startBtn.enabled = true
            self.busyIndicator.stopAnimating()
        }
        
        
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64){
        
        dispatch_async(dispatch_get_main_queue()) { 
            self.progressView.progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        }
        
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        
        if  error != nil {
            print("Error! download task fail. \(error) ")
            
            dispatch_async(dispatch_get_main_queue()) {
                self.startBtn.enabled = true
                self.busyIndicator.stopAnimating()
            }
        }
        
        
    }

}

