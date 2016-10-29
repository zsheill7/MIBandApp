//
//  AdminStatusTableViewController.swift
//  MI Band
//
//  Created by Zoe on 9/9/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class AdminStatusViewController: UIViewController {
    
    let user = PFUser.currentUser()

    
    func displayAlert(title: String, message: String) {
        
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                
                
            })))
            
            self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
       
    }
    
    
    
    @IBAction func bandMemberTapped(sender: AnyObject) {
        
        user!["isSectionLeader"] = false
        
        user!["isAdmin"] = false
        
        let main2Storyboard = UIStoryboard(name: "Main2", bundle: nil)
        let VC = main2Storyboard.instantiateViewControllerWithIdentifier("userSetupVC")
        self.presentViewController(VC, animated: true, completion: nil)
    }
    
    @IBAction func sectionLeaderTapped(sender: AnyObject) {
        
        user!["isSectionLeader"] = true
        
        user!["isAdmin"] = false
        user!.saveInBackground()
        let alertController = UIAlertController(title: "Please Enter Password", message: "", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action: UIAlertAction!) in
        }
        
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action: UIAlertAction!) in
            let passwordTextField = alertController.textFields![0] as UITextField
            
            if let enteredPassword = passwordTextField.text{
                if enteredPassword == "PPP" {
                    let main2Storyboard = UIStoryboard(name: "Main2", bundle: nil)
                    let VC = main2Storyboard.instantiateViewControllerWithIdentifier("userSetupVC")
                    self.presentViewController(VC, animated: true, completion: nil)
                    
                } else {
                    self.displayAlert("Incorrect Password", message: "Please try again")
                }
            }
        }
        
        
        alertController.addTextFieldWithConfigurationHandler { (textField: UITextField! ) in
            textField.placeholder = "Password"
            textField.secureTextEntry = true
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func adminTapped(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Please Enter Password", message: "", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action: UIAlertAction!) in
        }
        
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action: UIAlertAction!) in
            let passwordTextField = alertController.textFields![0] as UITextField
            
            if let enteredPassword = passwordTextField.text{
                if enteredPassword == "Australia2015" {
             
                    self.user!["isAdmin"] = true
                    self.user!["isSectionLeader"] = false
                    
                    self.user!["marchingInstrument"] = " "
                    self.user!["concertInstrument"] = " "
                    //user!["concertInstrument"]
                    self.user!["concertBandType"] = " "
                    self.user!["grade"] = " "
                    
                    self.user!.saveInBackground()
                    let main2Storyboard = UIStoryboard(name: "Main2", bundle: nil)
                    
                    let VC = main2Storyboard.instantiateViewControllerWithIdentifier("tabBarController")
                    self.presentViewController(VC, animated: true, completion: nil)
                } else {
                    self.displayAlert("Incorrect Password", message: "Please try again")
                }
            }
        }
        
        
        alertController.addTextFieldWithConfigurationHandler { (textField: UITextField! ) in
            textField.placeholder = "Password"
            textField.secureTextEntry = true
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
}
