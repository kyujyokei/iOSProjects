//
//  ViewController.swift
//  HelloTableView
//
//  Created by Kero on 2016/5/14.
//  Copyright © 2016年 Kero. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource , UITableViewDelegate {

    let fruitArray = ["apple","banana","mango","watermelon"]
    let colorArray = ["red","green","blue"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return fruitArray.count
        }else{
            return colorArray.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = UITableViewCell()
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath)
        cell.textLabel?.text = fruitArray[indexPath.row]
        
        if indexPath.section == 0 {
            cell.textLabel?.text = fruitArray[indexPath.row]
        }else{
            cell.textLabel?.text = colorArray[indexPath.row]
        }
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "FRUIT"
        }else{
            return "COLOR"
        }
    }
}

