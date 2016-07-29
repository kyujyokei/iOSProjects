//
//  ViewController.swift
//  HelloUIPickerView
//
//  Created by Kero on 2016/4/8.
//  Copyright © 2016年 Kero. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate {

    let numberArray = ["1","2","3","4","5","6","7","8"]
    let fruitArray = ["apple","banana","mango","watermelon"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return numberArray.count
        }else{
            return fruitArray.count
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            return numberArray[row]
        }else{
            return fruitArray[row]
        }
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            print("number: \(numberArray[row])")
        }else{
            print("fruit: \(fruitArray[row])")
        }
    }

}


