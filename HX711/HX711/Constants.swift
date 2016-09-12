//
//  Constants.swift
//  HX711
//
//  Created by Kero on 2016/9/7.
//  Copyright © 2016年 Kero. All rights reserved.
//


struct Constants {
    
    struct NotificationKeys {
        static let SignedIn = "onSignInCompleted"
    }
    
    struct Segues {
        static let SignInToFp = "SignInToFP"
        static let FpToSignIn = "FPToSignIn"
    }
    
    struct MessageFields {
        static let name = "time"
        static let text = "weight"
        static let photoUrl = "photoUrl"
        static let imageUrl = "imageUrl"
    }
}