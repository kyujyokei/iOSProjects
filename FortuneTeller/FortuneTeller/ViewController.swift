//
//  ViewController.swift
//  FortuneTeller
//
//  Created by Kero on 2016/3/13.
//  Copyright © 2016年 Kero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var resultArray=["大吉","中吉","小吉","末吉","凶"]
    var number = Int(arc4random_uniform(5))

    
    @IBOutlet weak var Result: UILabel!
    @IBAction func pressButton(sender: AnyObject) {

            Result.text = resultArray[number]
         number = Int(arc4random_uniform(5))

    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

