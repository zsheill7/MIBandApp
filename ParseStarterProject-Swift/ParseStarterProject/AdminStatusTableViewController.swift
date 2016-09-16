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
        
        let main2Storyboard = UIStoryboard(name: "Main2", bundle: nil)
        let VC = main2Storyboard.instantiateViewControllerWithIdentifier("userSetupVC")
        self.presentViewController(VC, animated: true, completion: nil)
    }
    
    @IBAction func sectionLeaderTapped(sender: AnyObject) {
        
        user!["isSectionLeader"] = true
        
        user!["isAdmin"] = false
        user!.saveInBackground()
        
        let main2Storyboard = UIStoryboard(name: "Main2", bundle: nil)
        let VC = main2Storyboard.instantiateViewControllerWithIdentifier("userSetupVC")
        self.presentViewController(VC, animated: true, completion: nil)
    }
    
    @IBAction func adminTapped(sender: AnyObject) {
        
        user!["isAdmin"] = true
        user!["isSectionLeader"] = false
        
        user!["marchingInstrument"] = " "
        user!["concertInstrument"] = " "
        //user!["concertInstrument"]
        user!["concertBandType"] = " "
        user!["grade"] = " "
        
        user!.saveInBackground()
        let main2Storyboard = UIStoryboard(name: "Main2", bundle: nil)
        
        let VC = main2Storyboard.instantiateViewControllerWithIdentifier("tabBarController")
        self.presentViewController(VC, animated: true, completion: nil)
    }
    
}
