//
//  TableViewController.swift
//  ParseBandApp
//
//  Created by Zoe Sheill on 7/9/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse


let marchingInstrumentsList = ["Flute", "Clarinet", "Bassoon", "Alto Saxophone", "Low Saxophone", "Trumpet", "Trombone", "Mellophone", "Sousaphone", "Percussion"]

let concertInstrumentsList = ["Flute", "Oboe", "Clarinet", "Bassoon", "Alto Saxophone", "Low Saxophone", "Trumpet", "Trombone", "French Horn", "Tuba", "Euphonium", "Percussion"]

let bandTypesList = ["6th Grade Band", "7th Grade Band", "8th Grade Band", "Concert Band", "Percussion Ensemble", "Symphonic Band", "Wind Symphony", "Wind Ensemble"]



class UserSetupTableViewController: UITableViewController {
    
    
   
    
    var user = PFUser.currentUser()
    
    @IBOutlet weak var isAdmin: UISwitch!

    @IBOutlet weak var isSectionLeader: UISwitch!
    @IBOutlet weak var marchingTableView: UITableView!

    
    @IBOutlet weak var concertInstTableView: UITableView!
    @IBOutlet weak var bandTypeTableView: UITableView!
   
    func displayAlert(title: String, message: String) {
        
        if #available(iOS 8.0, *) {
            var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                
                self.dismissViewControllerAnimated(true, completion: nil)
                
            })))
            
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            print("error")
        }
        
        
        
    }
    
    
    @IBOutlet weak var scroller: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.marchingTableView.reloadData()
        self.concertInstTableView.reloadData()
        
        scroller.contentSize = CGSizeMake(400, 1600)
    }
    
    override func viewDidLayoutSubviews() {
        scroller.scrollEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }*/

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if (tableView == marchingTableView) {
            return marchingInstrumentsList.count
        } else if (tableView == concertInstTableView) {
            return concertInstrumentsList.count
        } else if (tableView == bandTypeTableView) {
            return bandTypesList.count
        }
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        //print(concertInstrumentsList[indexPath.row])
        
        if (tableView == marchingTableView) {
            cell.textLabel?.text = String(marchingInstrumentsList[indexPath.row])
            return cell
        }
        else if (tableView == concertInstTableView) {
            cell.textLabel?.text = String(concertInstrumentsList[indexPath.row])
            return cell
        } else if (tableView == bandTypeTableView) {
            cell.textLabel?.text = String(bandTypesList[indexPath.row])
            return cell
        }
        
        cell.textLabel?.text = ""
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        let cellText:String = currentCell.textLabel!.text!
        
        if (tableView == marchingTableView) {
           
            
        user!.setObject(cellText, forKey: "marchingInstrument")
            
            //print(currentCell.textLabel!.text!)
        }
        else if (tableView == concertInstTableView) {

        user!.setObject(cellText, forKey: "concertInstrument")
            
        }
        else if (tableView == bandTypeTableView) {
            user!.setObject(cellText, forKey: "concertBandType")
        }
        user!.saveInBackground()
        
    }
    
    @IBAction func finishButton(sender: AnyObject) {
        user!.setObject(isSectionLeader.on, forKey: "isSectionLeader")
        user!.saveInBackground()
        user!.setObject(isAdmin.on, forKey: "isAdmin")
        user!.saveInBackground()
        
        if user!["marchingInstrument"] != nil && user!["concertInstrument"] != nil && user!["concertBandType"] != nil{
            self.performSegueWithIdentifier("finishSetup", sender: self)
        } else {
            displayAlert("Missing Fields", message: "Please select: \nA marching band instrument\n C band instrument\nyour concert band")
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
