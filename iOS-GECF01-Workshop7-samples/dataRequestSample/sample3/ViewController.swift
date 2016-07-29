//
//  ViewController.swift
//  sample3
//
//  Created by Adam Lin on 2016/6/3.
//  Copyright © 2016年 AdamLin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var busyIndicator:UIActivityIndicatorView!
    var session:NSURLSession!
    var datas:NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: NSURLSession Data fetch methods
    func fetchData(){
        
        session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        let url = NSURL(string: "http://lod2.apc.gov.tw/APCDataApi.ashx?apiId=102010&format=json")
        let dataTask = session.dataTaskWithURL(url!) { (data, response, error) in
            
            dispatch_async(dispatch_get_main_queue(), {
                self.busyIndicator.stopAnimating()
            })
            
            guard error == nil else{
                print("Error! data task with error=\(error)")
                return
            }
            
            guard let responseData = data else{
                print("Error! response data is nil")
                return
            }
            
            do {
                let parsedDatas = try NSJSONSerialization.JSONObjectWithData(responseData, options: .AllowFragments)
                
                self.datas = parsedDatas as? NSArray
                dispatch_async(dispatch_get_main_queue(), { 
                    self.tableView.reloadData()
                })
                
            }catch {
                
                print("Error! JsonObjectWithData fail. \(error)")
            }
        }
        
        dataTask.resume()
    }
    
    //MARK: UITableviewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let items = datas {
            return items.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cells")
        
        if indexPath.row % 2 == 0 {
            cell?.backgroundColor = UIColor.whiteColor()
        }else {
            cell?.backgroundColor = UIColor.lightGrayColor()
        }
        
        let item = datas![indexPath.row] as! NSDictionary
        cell?.textLabel!.text = item["Name"] as? String
        cell?.detailTextLabel!.text = item["TravelItinerary"] as? String
        
        return cell!
    }
    


}

