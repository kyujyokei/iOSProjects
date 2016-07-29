//
//  FirstViewController.swift
//  ToDoList
//
//  Created by Kero on 2016/5/18.
//  Copyright © 2016年 Kero. All rights reserved.
//

import UIKit

var tasks = [String]()

class FirstViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}

