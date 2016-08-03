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

let bandTypesList = ["Concert Band", "Symphonic Band", "Wind Symphony", "Wind Ensemble", "Percussion Ensemble"]
let gradeList = ["9th Grade", "10th Grade", "11th Grade", "12th Grade"]



class UserSetupTableViewController: UITableViewController {
    
    
   
    
    var user = PFUser.currentUser()
    
   
    //@IBOutlet weak var marchingTableView: UITableView!

    

   
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*marchingTableView.delegate = self
        marchingTableView.dataSource = self

        concertInstTableView.delegate = self
        concertInstTableView.dataSource = self
        
        bandTypeTableView.delegate = self
        bandTypeTableView.dataSource = self
        
        self.marchingTableView.reloadData()*/
        //self.concertInstTableView.reloadData()
        //self.bandTypeTableView.reloadData()
        

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func nextButton(sender: AnyObject) {
        
        
        if user!["marchingInstrument"] != nil && user!["concertInstrument"] != nil && user!["concertBandType"] != nil{
            self.performSegueWithIdentifier("finishSetup", sender: self)
        } else {
            displayAlert("Missing Fields", message: "Please select: \nA marching band instrument\n A concert band instrument\nYour concert band")
        }
    }
    // MARK: - Table view data source

    /*func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }*/

    /*override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if (tableView == marchingTableView) {
            //print(marchingInstrumentsList.count)
            return marchingInstrumentsList.count
        } else if (tableView == concertInstTableView) {
            return concertInstrumentsList.count
        } else if (tableView == bandTypeTableView) {
            return bandTypesList.count
        }
        //return 1
        return 0
    }*/

    
    /*override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        //print(concertInstrumentsList[indexPath.row])
        
        /*if (tableView == marchingTableView) {
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
        */
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
    */
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
    }*/
    

}

