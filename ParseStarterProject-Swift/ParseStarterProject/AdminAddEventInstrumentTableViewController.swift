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
    
    var instruments:[String] = []
    
    override func viewDidLoad() {
        self.tableView.reloadData()
        
        self.tableView.allowsMultipleSelection = true
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return concertInstrumentsList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.textLabel?.text = String(concertInstrumentsList[indexPath.row])
        
        return cell
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
        
        let cellText = tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text
        instruments.append(cellText!)
    }
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.None
        
        let cellText = tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text
        instruments = instruments.filter { $0 != cellText}
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as! AdminAddEventOneTableViewController
        
        destinationVC.instruments = instruments
        
    }
}
