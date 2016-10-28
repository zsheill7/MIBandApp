//
//  TableViewController.swift
//  ParseBandApp
//
//  Created by Zoe Sheill on 7/9/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse


let marchingInstrumentsList = ["Flute", "Clarinet", "Bassoon", "Alto Saxophone", "Low Saxophone", "Trumpet", "Trombone", "Mellophone", "Sousaphone", "Percussion", "Drum Major"]

let concertInstrumentsList = ["Flute", "Oboe", "Clarinet", "Bass Clarinet", "Bassoon", "Alto Saxophone", "Tenor Saxophone", "Baritone Saxophone", "Trumpet", "Trombone", "French Horn", "Tuba", "Euphonium", "Percussion", "Piano"]

let bandTypesList = ["Concert Band", "Symphonic Band", "Wind Symphony", "Wind Ensemble", "Percussion Ensemble"]

let gradeList = ["9th Grade", "10th Grade", "11th Grade", "12th Grade"]



class UserSetupTableViewController: UITableViewController {
    
    

    
    var user = PFUser.currentUser()
    
   
    //@IBOutlet weak var marchingTableView: UITableView!

    var downArrow = UIButton(type: .System)
    var upArrow = UIButton(type: .System)
   
    
    func displayAlert(title: String, message: String) {
        
        if #available(iOS 8.0, *) {
            var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                
                //self.dismissViewControllerAnimated(true, completion: nil)
                
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
        let totalHeight = self.tableView.frame.size.height + 65
        if  totalHeight > self.view.frame.size.height {
            downArrow = UIButton(frame: CGRect(x: self.view.frame.size.width - 50, y: self.view.frame.size.height - 100, width: 50, height: 50))
            downArrow.tag = 1
            downArrow.setImage(UIImage(named: "down"), forState: .Normal)
            downArrow.addTarget(self, action: #selector(UserSetupTableViewController.scrollDown(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            //self.view.addSubview(downArrow)
        }
        
        

    }
    
    func scrollDown(sender: UIButton!) {
        //self.tableView.contentOffset.y = self.view.frame.size.height
        
        let indexPath = NSIndexPath(forRow: 0, inSection: 2)
        self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
        print("here")
        
        if let viewWithTag = self.view.viewWithTag(1) {
            viewWithTag.removeFromSuperview()
        }else{
            print("tag not found")
        }
        //self.view.willRemoveSubview(downArrow)
        
        upArrow = UIButton(frame: CGRect(x: self.view.frame.size.width - 50, y: 150, width: 50, height: 50))
        upArrow.tag = 2
        
        upArrow.setImage(UIImage(named: "up"), forState: .Normal)
        upArrow.addTarget(self, action: #selector(UserSetupTableViewController.scrollUp(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        self.view.addSubview(upArrow)

    
    }
    func scrollUp(sender: UIButton!) {
        //self.tableView.contentOffset.y = self.view.frame.size.height
        
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
        print("here")
        if let viewWithTag = self.view.viewWithTag(2) {
            viewWithTag.removeFromSuperview()
        }else {
            print("tag not found")
        }
        
        
            downArrow = UIButton(frame: CGRect(x: self.view.frame.size.width - 50, y: self.view.frame.size.height - 100, width: 50, height: 50))
            downArrow.tag = 1
            downArrow.setImage(UIImage(named: "down"), forState: .Normal)
            downArrow.addTarget(self, action: #selector(UserSetupTableViewController.scrollDown(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            self.view.addSubview(downArrow)
        
        
        
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func nextButton(sender: AnyObject) {
        
        
        if user!["marchingInstrument"] != nil && user!["concertInstrument"] != nil /*&& user!["concertBandType"] != nil*/{
            self.performSegueWithIdentifier("nextPage", sender: self)
        } else {
            displayAlert("Missing Fields", message: "Please select: \nA marching band instrument\n A concert band instrument")
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if DeviceType.IS_IPAD || DeviceType.IS_IPAD_PRO {
            if (indexPath.section == 0 || indexPath.section == 1) && indexPath.row == 0 {
                return 350
            }
            

        }
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
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

