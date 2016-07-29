//
//  SecondViewController.swift
//  ToDoList
//
//  Created by Kero on 2016/5/18.
//  Copyright © 2016年 Kero. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var myTextField: UITextField!

    @IBAction func changeText(sender: UITextField) {
        if myTextField.text == ""{//如果沒有輸入文字
            addButton.setTitle("Back", forState: .Normal) //普通
            addButton.setTitle("Back", forState: .Selected) //按下去時
        }else{//如有輸入文字
            addButton.setTitle("Add", forState: .Normal)
            addButton.setTitle("Add", forState: .Selected)
        }
        
    }

    @IBOutlet weak var addButton: UIButton!
   
    @IBAction func addTasks(sender: UIButton) {
        if myTextField.text != ""{//如果有輸入文字
            //存擋
            tasks.append(myTextField.text!)
            NSUserDefaults.standardUserDefaults().setObject(tasks, forKey: "tasks")
        }
        myTextField.text = ""
        myTextField.resignFirstResponder() //收回鍵盤
        self.tabBarController?.selectedIndex = 0 //轉移回第一個畫面
    }
    
    override func viewDidLoad() {
         myTextField.becomeFirstResponder()
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
    
    override func viewWillAppear(animated: Bool) {//每次出現這個畫面時
        myTextField.becomeFirstResponder() //開啟畫面時跳出鍵盤
        addButton.setTitle("Back", forState: .Normal) //普通顯示Back
        addButton.setTitle("Back", forState: .Selected) //按下去時顯示Back
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool { //控制鍵盤上的return鍵
        
        if myTextField.text != ""{//如果有輸入文字
            tasks.append(myTextField.text!) //存擋
            NSUserDefaults.standardUserDefaults().setObject(tasks, forKey: "tasks")
         
        myTextField.text = ""
        myTextField.resignFirstResponder() //收回鍵盤
        self.tabBarController?.selectedIndex = 0 //轉移回第一個畫面
        }
        return true
        
    }

}

