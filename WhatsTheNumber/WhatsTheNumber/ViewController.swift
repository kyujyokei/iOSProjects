//
//  ViewController.swift
//  WhatsTheNumber
//
//  Created by Kero on 2016/3/13.
//  Copyright © 2016年 Kero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var answer = Int(arc4random_uniform(100)+1)
    var maxNumber = 100
    var minNumber = 1
    var isOver = false
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var InputTextField: UITextField!
    
    @IBAction func makeGuess(sender: AnyObject) {
        
        if isOver == false{
            let inputNumber = Int(InputTextField.text!)
            InputTextField.text = ""
            
            if  inputNumber == nil {messageLabel.text = "Come on input something!!NEVER GIVE UP!!!!"
            }else if inputNumber > maxNumber{
                messageLabel.text = "Too large! Guess a number between \(minNumber)~\(maxNumber)"
            }else if inputNumber < minNumber{
                messageLabel.text = "Too small! Guess a number between \(minNumber)~\(maxNumber)"
            }else if inputNumber == answer {
                messageLabel.text = "You are right! Press [Guess] to play again!"
                isOver = true
            }else if inputNumber < answer {
                minNumber = inputNumber!
                messageLabel.text = "Try again! Guess a number between \(minNumber)~\(maxNumber)"
            }else if inputNumber > answer {
                maxNumber = inputNumber!
                messageLabel.text = "Try again! Guess a number between \(minNumber)~\(maxNumber)"
            }
        }else{
            messageLabel.text = "Guess a number between \(minNumber)~\(maxNumber)"
            maxNumber = 100
            minNumber = 1
            answer = Int(arc4random_uniform(100)+1)
            print(answer)
            isOver = false
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(answer)
        InputTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
            return true
    }

}

