//
//  ViewController.swift
//  WhatsYourName
//
//  Created by Kero on 2016/3/11.
//  Copyright © 2016年 Kero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myTextInput: UITextField!

    
    @IBOutlet weak var myLabel: UILabel!
    
    @IBAction func buttonPressed(sender: UIButton) {
        myLabel.text="Hello,\(myTextInput.text!)"
        print(myTextInput.text!)
        
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

