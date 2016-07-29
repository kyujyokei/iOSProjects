//
//  ViewController.swift
//  ＰrimeNumber
//
//  Created by Kero on 2016/3/24.
//  Copyright © 2016年 Kero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!

    @IBAction func doThePrimeTest(sender: UIButton) {
        
        enum primeEnum{
            case prime
            case notPrime
            case reEnter
        }

        var isPrime:primeEnum
        
        if inputTextField.text!.isEmpty == true{
            resultLabel.text = "Please enter something!"
            resultLabel.hidden = false
            
        }else{
            isPrime = .prime
            let inputNumber = Int(inputTextField.text!)!
            
            //1:Prime 2:Not Prime 0:Please ReEnter
            
            if inputNumber == 0{
                isPrime = .reEnter
            }else if inputNumber == 1{
                isPrime = .prime
            }else{
                for var i = 2 ; i < inputNumber ; i++ {
                    if inputNumber % i == 0{
                        isPrime = .notPrime
                    }
                }
            }
            
            switch isPrime{
            case .notPrime:
                resultLabel.text = "\(inputNumber) is not a prime number"
            case .prime:
                resultLabel.text = "\(inputNumber) is a prime number"
            case .reEnter:
                resultLabel.text = "0 is not a prime number, please re-enter"
            }

            
            //if isPrime == 0{
            //    resultLabel.text = "0 is not a prime"
            //}else if isPrime == 1{
            //    resultLabel.text = "\(inputNumber) is a prime number"
            //}else if isPrime == 2{
            //    resultLabel.text = "\(inputNumber) is not a prime number"
            //}
            
            resultLabel.hidden = false
        }
        
        inputTextField.text = ""
    }
    
    @IBOutlet weak var resultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        inputTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prefersStatusBarHidden() -> Bool{
        return true
    }
}

