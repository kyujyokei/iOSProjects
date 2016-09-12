//
//  ViewController.swift
//  HX711
//
//  Created by Kero on 2016/9/7.
//  Copyright © 2016年 Kero. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableCell: UITableViewCell!
    
    var data = {}
    
    private var _refHandle: FIRDatabaseHandle!
    
    var messages: [FIRDataSnapshot]! = []
    var ref: FIRDatabaseReference!
    var storageRef: FIRStorageReference!
    var remoteConfig: FIRRemoteConfig!
    
    let rootRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDatabase()
        configureStorage()
        configureRemoteConfig()
        fetchConfig()

        logViewLoaded()
        

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Dequeue cell
        let cell: UITableViewCell! = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        // Unpack message from Firebase DataSnapshot
        let messageSnapshot: FIRDataSnapshot! = self.messages[indexPath.row]
        let message = messageSnapshot.value as! Dictionary<String, String>
        let name = message[Constants.MessageFields.name] as String!
        if let imageUrl = message[Constants.MessageFields.imageUrl] {
            if imageUrl.hasPrefix("gs://") {
                FIRStorage.storage().referenceForURL(imageUrl).dataWithMaxSize(INT64_MAX){ (data, error) in
                    if let error = error {
                        print("Error downloading: \(error)")
                        return
                    }
                    cell.imageView?.image = UIImage.init(data: data!)
                }
            } else if let url = NSURL(string:imageUrl), data = NSData(contentsOfURL: url) {
                cell.imageView?.image = UIImage.init(data: data)
            }
            cell!.textLabel?.text = "sent by: \(name)"
        } else {
            let text = message[Constants.MessageFields.text] as String!
            cell!.textLabel?.text = name + ": " + text
            cell!.imageView?.image = UIImage(named: "ic_account_circle")
            if let photoUrl = message[Constants.MessageFields.photoUrl], url = NSURL(string:photoUrl), data = NSData(contentsOfURL: url) {
                cell!.imageView?.image = UIImage(data: data)
            }
        }

        
        return cell
    }
    
    deinit {
        self.ref.child("messages").removeObserverWithHandle(_refHandle)
    }
    
    func configureDatabase() {
        ref = FIRDatabase.database().reference()
        // Listen for new messages in the Firebase database
        _refHandle = self.ref.child("messages").observeEventType(.ChildAdded, withBlock: { (snapshot) -> Void in
            self.messages.append(snapshot)
            self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: self.messages.count-1, inSection: 0)], withRowAnimation: .Automatic)
        })
        
        print(messages)
    }
    
    func configureStorage() {
        storageRef = FIRStorage.storage().referenceForURL("gs://watercup-e06b3.appspot.com")
    }
    
    func configureRemoteConfig() {
        remoteConfig = FIRRemoteConfig.remoteConfig()
        // Create Remote Config Setting to enable developer mode.
        // Fetching configs from the server is normally limited to 5 requests per hour.
        // Enabling developer mode allows many more requests to be made per hour, so developers
        // can test different config values during development.
        let remoteConfigSettings = FIRRemoteConfigSettings(developerModeEnabled: true)
        remoteConfig.configSettings = remoteConfigSettings!
    }
    
    func fetchConfig() {
        var expirationDuration: Double = 3600
        // If in developer mode cacheExpiration is set to 0 so each fetch will retrieve values from
        // the server.
        if (self.remoteConfig.configSettings.isDeveloperModeEnabled) {
            expirationDuration = 0
        }
    

    }
    func logViewLoaded() {
        FIRCrashMessage("View loaded")
    }

}