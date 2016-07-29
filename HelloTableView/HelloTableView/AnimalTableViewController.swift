//
//  AnimalTableViewController.swift
//  HelloTableView
//
//  Created by Kero on 2016/5/17.
//  Copyright © 2016年 Kero. All rights reserved.
//

import UIKit

class AnimalTableViewController: UITableViewController {
    let animalArray = ["cat","chicken","dog","elephant","fox","goat","kangaroo","monkey","mouse","penguin","rabbit","snail",]
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animalArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath)
            cell.textLabel?.text = animalArray[indexPath.row]
    
            cell.imageView?.image = UIImage(named: animalArray[indexPath.row])
        
            cell.accessoryType = .DisclosureIndicator
                return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
 
        self.performSegueWithIdentifier("showDetail", sender: indexPath.row)
    }
    
    override func viewDidLoad() {
        // 讓整個table view往下移動20
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) { //這裡直接作為 Detail 的 View Controller
        let selectedNumber = sender as! Int
        
        let vc = segue.destinationViewController //拿到segue執行後的新畫面
        let bigImageView = vc.view.subviews[0] as! UIImageView
        bigImageView.image = UIImage(named: animalArray[selectedNumber])
        vc.navigationItem.title = animalArray[selectedNumber]
    }
}

