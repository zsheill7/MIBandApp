//
//  AdminAddEventInstrumentTableViewController.swift
//  MI Band
//
//  Created by Zoe on 9/11/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class AdminAddEventInstrumentTableViewController: UITableViewController {
    
    var event = PFObject()
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return concertInstrumentsList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.textLabel?.text = String(marchingInstrumentsList[indexPath.row])
        
        return cell
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as! AdminAddEventOneTableViewController
        destinationVC.event = event
    }
}
