//
//  AppState.swift
//  HX711
//
//  Created by Kero on 2016/9/7.
//  Copyright © 2016年 Kero. All rights reserved.
//

import Foundation

class AppState: NSObject {
    
    static let sharedInstance = AppState()
    
    var signedIn = false
    var displayName: String?
    var photoUrl: NSURL?
}