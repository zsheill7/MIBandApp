//
//  LoginViewController.swift
//  ParseBandApp
//
//  Created by Zoe Sheill on 7/21/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
  
   
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
     var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func displayAlert(title: String, message: String) {
        
        if #available(iOS 8.0, *) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                
                               
            })))
            
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            print("error")
        }
        
        
        
    }

    
    @IBAction func logIn(sender: AnyObject) {
        
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        var errorMessage = "Please try again later"

        
        
        PFUser.logInWithUsernameInBackground(username.text!, password: password.text!, block: { (user, error) -> Void in
            
            self.activityIndicator.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            
            if user != nil {
                
                // Logged In!
                
                dispatch_async(dispatch_get_main_queue()) {
                    [unowned self] in
                    self.performSegueWithIdentifier("login", sender: self)
                }
                
                
            } else {
                
                if let errorString = error!.userInfo["error"] as? String {
                    
                    errorMessage = errorString
                    
                }
                
                self.displayAlert("Failed Login", message: errorMessage)
                
            }
            
        })
    }
    
    
    @IBAction func signUp(sender: AnyObject) {
        
        self.performSegueWithIdentifier("loginToSignup", sender: self)
    }
    

}
