//
//  ViewController.swift
//  Timer
//
//  Created by Kero on 2016/5/2.
//  Copyright © 2016年 Kero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var counterLabel: UILabel!
    
    var time = 0
    
    @IBAction func startButton(sender: UIButton) {
    }

    @IBAction func stopButton(sender: UIButton) {
    }
    
    @IBAction func resetButton(sender: UIButton) {
        time = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

