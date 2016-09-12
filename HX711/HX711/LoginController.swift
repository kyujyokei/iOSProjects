//
//  LoginController.swift
//  HX711
//
//  Created by Kero on 2016/9/7.
//  Copyright © 2016年 Kero. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginController: UIViewController {
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    @IBAction func loginButtonAction(sender: UIButton) {
//        // Sign In with credentials.
//        let email = emailTextfield.text
//        let password = passwordTextfield.text
//        FIRAuth.auth()?.signInWithEmail(email!, password: password!) { (user, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//            self.signedIn(user!)
//        }
        
        performSegueWithIdentifier("goNext", sender: nil)
    }
    
    @IBAction func forgotPswdBtnAction(sender: UIButton) {
        let prompt = UIAlertController.init(title: nil, message: "Email:", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.Default) { (action) in
            let userInput = prompt.textFields![0].text
            if (userInput!.isEmpty) {
                return
            }
            FIRAuth.auth()?.sendPasswordResetWithEmail(userInput!) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
        }
        prompt.addTextFieldWithConfigurationHandler(nil)
        prompt.addAction(okAction)
        presentViewController(prompt, animated: true, completion: nil);
        
    }
    
    
    @IBAction func signUpBtnAction(sender: UIButton) {
        let email = emailTextfield.text
        let password = passwordTextfield.text
        FIRAuth.auth()?.createUserWithEmail(email!, password: password!) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.setDisplayName(user!)
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
//        if let user = FIRAuth.auth()?.currentUser {
//            self.signedIn(user)
//        }
    }
    
    
    func setDisplayName(user: FIRUser) {
        let changeRequest = user.profileChangeRequest()
        changeRequest.displayName = user.email!.componentsSeparatedByString("@")[0]
        changeRequest.commitChangesWithCompletion(){ (error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.signedIn(FIRAuth.auth()?.currentUser)
        }
    }
    
    func signedIn(user: FIRUser?) {
        MeasurementHelper.sendLoginEvent()
        
        AppState.sharedInstance.displayName = user?.displayName ?? user?.email
        AppState.sharedInstance.photoUrl = user?.photoURL
        AppState.sharedInstance.signedIn = true
        NSNotificationCenter.defaultCenter().postNotificationName(Constants.NotificationKeys.SignedIn, object: nil, userInfo: nil)
        performSegueWithIdentifier(Constants.Segues.SignInToFp, sender: nil)
    }

}
