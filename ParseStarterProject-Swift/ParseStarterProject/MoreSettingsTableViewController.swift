//
//  MoreSettingsTableViewController.swift
//  ParseBandApp
//
//  Created by Zoe on 8/28/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class MoreSettingsTableViewController: UITableViewController {

    
    var user = PFUser.currentUser()
    @IBOutlet weak var willRepeatSwitch: UISwitch!
    
    override func viewDidLoad() {
        
    }
    
    
    @IBAction func toggleWillRepeat(sender: AnyObject) {
        
        /*if sender.on == true {
            user!["willRepeat"] = true
        } else {
            user!["willRepeat"] = false
        }*/
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("switch: " + String(willRepeatSwitch.on))
        if let destinationVC = segue.destinationViewController as? AddEventTableViewController {
            destinationVC.willRepeat = willRepeatSwitch.on
        }
    }
}
