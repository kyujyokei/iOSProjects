//
//  ViewController.swift
//  ColorFInder
//
//  Created by Kero on 2016/4/1.
//  Copyright © 2016年 Kero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var redValue = 255
    var greenValue = 255
    var blueValue = 255
    
    @IBOutlet weak var redText: UILabel!
    @IBOutlet weak var greenText: UILabel!
    @IBOutlet weak var blueText: UILabel!
   
    
    @IBAction func RedSliderChanged(sender: UISlider) {
        redValue = lroundf(sender.value)
        redText.text = "R: \(lroundf(sender.value))"
        changeBackgroundColor()
    }
    
    @IBAction func GreenSliderChanged(sender: UISlider) {
        greenValue = lroundf(sender.value)
        greenText.text = "G: \(greenValue)"
        changeBackgroundColor()
    }
    
    @IBAction func BlueSliderChanged(sender: UISlider) {
        blueValue = lroundf(sender.value)
        blueText.text = "B: \(blueValue)"
        changeBackgroundColor()
    }

    func changeBackgroundColor(){
        self.view.backgroundColor = UIColor(red: CGFloat(redValue)/255.0, green: CGFloat(greenValue)/255.0, blue:CGFloat(blueValue)/255.0, alpha: 1)
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

