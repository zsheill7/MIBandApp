//
//  AdminAddEventEnsembleTableViewController.swift
//  MI Band
//
//  Created by Zoe on 9/11/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
 var ensembles: [String] = []

class AdminAddEventEnsembleTableViewController: UITableViewController {
    
   
    
    override func viewDidLoad() {
        self.tableView.reloadData()
        self.tableView.allowsMultipleSelection = true
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bandTypesList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        print("here2")
        cell.textLabel?.text = String(bandTypesList[indexPath.row])
        return cell
    }
    
    
    
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        let destinationVC = segue.destinationViewController as! AdminAddEventOneTableViewController
        destinationVC.ensembles = ensembles
        print("inPFS")
       
    }
    override func viewWillDisappear(animated: Bool) {
        let destinationVC = storyboard?.instantiateViewControllerWithIdentifier("adminAddEvent") as! AdminAddEventOneTableViewController
        destinationVC.ensembles = ensembles
        print("in View Will Dis")
        print(ensembles)
    }*/
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
        
        let cellText = tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text
        ensembles.append(cellText!)
        print("inDidSelect")
    }
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.None
        
        let cellText = tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text
        ensembles = ensembles.filter { $0 != cellText}
    }

    
}
