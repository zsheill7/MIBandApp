//
//  LoginViewController.swift
//  ParseBandApp
//
//  Created by Zoe Sheill on 7/21/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse


class LoginViewController: UIViewController, UITextFieldDelegate {
  
   
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
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser()?["grade"] != nil {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main2", bundle: nil)
            let viewController = mainStoryboard.instantiateViewControllerWithIdentifier("tabBarController") as! UITabBarController
            UIApplication.sharedApplication().keyWindow?.rootViewController = viewController
            mainStoryboard.instantiateViewControllerWithIdentifier("tabBarController")
         
         
         }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        username.delegate = self
        password.delegate = self
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
                if user!["grade"] != nil {
                    dispatch_async(dispatch_get_main_queue()) {
                        [unowned self] in
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main2", bundle: nil)
                        let viewController = mainStoryboard.instantiateViewControllerWithIdentifier("tabBarController") as! UITabBarController
                        UIApplication.sharedApplication().keyWindow?.rootViewController = viewController
                        mainStoryboard.instantiateViewControllerWithIdentifier("tabBarController")
                       // self.presentViewController(viewController, animated: true, completion: nil)
                        //viewController.modalTransitionStyle = UIModalTransitionStyle.
                    }
                } else {
                    self.displayAlert("Failed login", message: "Please create a new account")
                }
                
                
            } else {
                
                if let errorString = error!.userInfo["error"] as? String {
                    
                    errorMessage = errorString
                    
                }
                
                self.displayAlert("Failed Login", message: errorMessage)
                
            }
            
        })
    }
    
    @IBAction func resetPasswordPressed(sender: AnyObject) {
        let titlePrompt = UIAlertController(title: "Reset password", message: "Enter your login email:", preferredStyle: .Alert)
        var titleTextField: UITextField?
        titlePrompt.addTextFieldWithConfigurationHandler { (textField) in
            titleTextField = textField
            textField.placeholder = "Email"
            
            
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
        titlePrompt.addAction(cancelAction)
        
        titlePrompt.addAction(UIAlertAction(title: "Reset", style: .Destructive, handler: { (action) in
            if let textField = titleTextField {
                self.resetPassword(textField.text!)
            }
        }))
        self.presentViewController(titlePrompt, animated: true, completion: nil)
    }
    
    func resetPassword(email: String) {
        let emailToLowerCase = email.lowercaseString
        
        let emailClean = emailToLowerCase.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        PFUser.requestPasswordResetForEmailInBackground(emailClean) { (success, error) in
            if error == nil {
                let success = UIAlertController(title: "Success", message: "Check your email to reset your password", preferredStyle: .Alert)
                let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
                success.addAction(okButton)
                self.presentViewController(success, animated: false, completion: nil)
            } else {
                let errormessage = error!.userInfo["error"] as! NSString
                let error = UIAlertController(title: "Cannot complete request", message: errormessage as String, preferredStyle: .Alert)
                let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
                error.addAction(okButton)
                self.presentViewController(error, animated: false, completion: nil)
            }
        }
    }
    @IBAction func homeButtonTapped(sender: AnyObject) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialVC = mainStoryboard.instantiateViewControllerWithIdentifier("initialVC")
        
        self.presentViewController(initialVC, animated: true, completion: nil)
    }
    
    
    @IBAction func signUp(sender: AnyObject) {
        
        /*self.performSegueWithIdentifier("loginToSignup", sender: self)*/
        let createAccountNC = storyboard?.instantiateViewControllerWithIdentifier("createAccountNC")
        createAccountNC!.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(createAccountNC!, animated: true, completion: nil)
    }
    
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let isAppAlreadyLaunchedOnce = defaults.stringForKey("isAppAlreadyLaunchedOnce") {
            return true
        } else {
            defaults.setBool(true, forKey: "isAppAlreadyLaunchedOnce")
            return false
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    /*func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }*/
    

}
