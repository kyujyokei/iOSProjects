//
//  ViewController.swift
//  zoomPhoto
//
//  Created by Kero on 2016/4/15.
//  Copyright © 2016年 Kero. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate{

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myScrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myScrollView.minimumZoomScale = 1.0
        self.myScrollView.maximumZoomScale = 5.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.myImageView
    }
}

