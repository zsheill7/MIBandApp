//
//  SettingsTableViewController.swift
//  ParseBandApp
//
//  Created by Zoe Sheill on 7/18/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

extension UIColor {

    
    class func maroon() -> UIColor {
        return UIColor(red:0.55, green:0.09, blue:0.09, alpha:1.0)
    }
    
    class func titleGreen() -> UIColor {
        return UIColor(red: 145.0/255, green: 193.0/255, blue: 100.0/255, alpha: 1)
    }
    
    class func buttonBlue() -> UIColor {
        return UIColor(red:0.19, green:0.54, blue:0.98, alpha:1.0)
    }
}

class SettingsTableViewController: UITableViewController {


    @IBOutlet var table: UITableView!
   
    @IBOutlet weak var marchingInstCell: UITableViewCell!
    
    @IBOutlet weak var concertInstCell: UITableViewCell!
     @IBOutlet weak var ensembleTypeCell: UITableViewCell!
    
    @IBOutlet weak var marchingInst: UILabel!
    
    @IBOutlet weak var concertInst: UILabel!

    
    @IBOutlet weak var ensemble: UILabel!
    
    var user = PFUser.currentUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("test1")
        if let marchingInst = PFUser.currentUser()!["marchingInstrument"] as? String {
            print("test2")
            self.marchingInst.text! = marchingInst
        }
        
        if let concertInst = PFUser.currentUser()!["concertInstrument"] as? String {
            print("test2")
            self.concertInst.text! = concertInst
        }
        if let concertBandType = PFUser.currentUser()!["concertBandType"] as? String {
            print("test2")
            self.ensemble.text! = concertBandType
        }
        /*marchingInstCell.tag = 1
        concertInstCell.tag = 2
        ensembleTypeCell.tag = 3*/
        
        var frame: CGRect = table.frame;
        frame.size.height = table.contentSize.height
        table.frame = frame
        
    }
    
    override func viewDidAppear(animated: Bool) {
     
        
        if let marchingInst = PFUser.currentUser()!["marchingInstrument"] as? String {
            
            self.marchingInst.text! = marchingInst
        }
        
        if let concertInst = PFUser.currentUser()!["concertInstrument"] as? String {

            self.concertInst.text! = concertInst
        }
        if let concertBandType = PFUser.currentUser()!["concertBandType"] as? String {
            print("test3")
            self.ensemble.text! = concertBandType
        }
        
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segue_one" {
            let tableVC: SettingsInstrumentsTableViewController = segue.destinationViewController as! SettingsInstrumentsTableViewController
            
            tableVC.cellTag = 1
            tableVC.title = "Marching Instrument"
            
        } else if segue.identifier == "segue_two" {
            let tableVC: SettingsInstrumentsTableViewController = segue.destinationViewController as! SettingsInstrumentsTableViewController
            
            tableVC.cellTag = 2
            tableVC.title = "Concert Instrument"
            
        } else if segue.identifier == "segue_three" {
            let tableVC: SettingsInstrumentsTableViewController = segue.destinationViewController as! SettingsInstrumentsTableViewController
            
            tableVC.cellTag = 3
            tableVC.title = "Concert Band"
            
        }
    }
    
    
    @IBAction func deleteAccountPressed(sender: AnyObject) {
 
        
        if #available(iOS 8.0, *) {
            let alert = UIAlertController(title: "Are you sure you want to delete your account?", message: "All saved settings will be lost", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction((UIAlertAction(title: "Delete Account", style: .Destructive, handler: { (action) -> Void in
                self.user?.deleteInBackgroundWithBlock({ (success, error) in
                    PFUser.logOut()
                    let createAccountVC = self.storyboard?.instantiateViewControllerWithIdentifier("createAccountVC")
                    self.presentViewController(createAccountVC!, animated: true, completion: nil)
                })
                
                
            })))
            alert.addAction((UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action) -> Void in
               
                
            })))
            
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            print("error")
        }

    }
    @IBAction func logoutButtonPressed(sender: AnyObject) {
    if #available(iOS 8.0, *) {
        let alert = UIAlertController(title: "Logout", message: "Do you want to log out?", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            PFUser.logOutInBackgroundWithBlock({ (error) in
                if error != nil {
                    print(error)
                } else {
                    print("success")
                }
            })
            
            let loginNC = self.storyboard?.instantiateViewControllerWithIdentifier("loginNC")
            self.presentViewController(loginNC!, animated: true, completion: nil)
        

        })))
        alert.addAction((UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action) -> Void in
            
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
    } else {
    print("error")
    }

    }

    /*override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.textLabel!.textColor = UIColor.titleGreen()
    }*/
    
    
}
