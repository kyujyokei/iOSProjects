//
//  ViewController.swift
//  HelloUIImageview
//
//  Created by Kero on 2016/4/11.
//  Copyright © 2016年 Kero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstViewController = FirstViewController(nibName: "FirstViewController", bundle: nil)
        let secondViewController = SecondViewController(nibName: "SecondViewController", bundle: nil)
        let thirdViewController = ThirdViewController(nibName: "ThirdViewController", bundle: nil)
        let fourthViewController = FourthViewController(nibName: "FourthViewController", bundle: nil)
        
        var frame2 = secondViewController.view.frame
        frame2.origin.x = self.view.frame.size.width
        secondViewController.view.frame = frame2
        
        var frame3 = thirdViewController.view.frame
        frame3.origin.x = self.view.frame.size.width * 2
        thirdViewController.view.frame = frame3
        
        var frame4 = fourthViewController.view.frame
        frame4.origin.x = self.view.frame.size.width * 3
        fourthViewController.view.frame = frame4
        
        self.addChildViewController(firstViewController)
        self.myScrollView.addSubview(firstViewController.view)
        firstViewController.didMoveToParentViewController(self)
        
        self.addChildViewController(secondViewController)
        self.myScrollView.addSubview(secondViewController.view)
        secondViewController.didMoveToParentViewController(self)
        
        self.addChildViewController(thirdViewController)
        self.myScrollView.addSubview(thirdViewController.view)
        thirdViewController.didMoveToParentViewController(self)
        
        self.addChildViewController(fourthViewController)
        self.myScrollView.addSubview(fourthViewController.view)
        fourthViewController.didMoveToParentViewController(self)

        myScrollView.contentSize = CGSizeMake(self.view.frame.size.width * 4, self.view.frame.size.height)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

