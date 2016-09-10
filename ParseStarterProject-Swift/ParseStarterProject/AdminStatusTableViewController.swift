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

    override func viewDidLoad() {
       
    }
    
    @IBAction func bandMemberTapped(sender: AnyObject) {
        
        user!["isSectionLeader"] = true
        
        user!["isAdmin"] = true
        
        self.performSegueWithIdentifier("toUserSetup", sender: self)
    }
    
    @IBAction func sectionLeaderTapped(sender: AnyObject) {
        
        user!["isSectionLeader"] = true
        
        user!["isAdmin"] = false
        user!.saveInBackground()
        
        self.performSegueWithIdentifier("toUserSetup", sender: self)
    }
    
    @IBAction func adminTapped(sender: AnyObject) {
        
        user!["isAdmin"] = true
        user!["isSectionLeader"] = false
        user!.saveInBackground()
        user!["marchingInstrument"] = "None"
        user!["concertInstrument"] = "None"
        user!["concertBandType"] = "None"
        
        self.performSegueWithIdentifier("toTabBarController", sender: self)
    }
    
}
