//
//  EmailTableViewController.swift
//  MI Band
//
//  Created by Zoe on 9/9/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class EmailTableViewController: UITableViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    let emailArray = ["parker.bixby@mercerislandschools.org", "jen.mclellan@mercerislandschools.org", "Ryan.Lane@mercerislandschools.org",
                      "Bryan.Wanzer@mercerislandschools.org",
                      "Carol.Krell@mercerislandschools.org",
                      "David.Bentley@mercerislandschools.org"]
    
    let directorsArray =
        ["Parker Bixby",
         "Jen McLellan",
         "Ryan Lane",
         "Bryan Wanzer",
         "Carol Krell",
         "David Bentley"]
    
    let phoneNumbersArray = ["2062306324", //Bixby
        "2062306344", //McClellan
        "2062306325", //Lane
        "2062306325", //Wanzer
        "2062306175", //Krell
        "2062363343", //Bentley
    ]
    
    var displayEmails = true
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func viewDidLoad() {
        self.title = "Email a Director"
    }
    
    @IBAction func indexChanged(sender: AnyObject) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            displayEmails = true
            tableView.reloadData()
        case 1:
            displayEmails = false
            tableView.reloadData()
        default:
            break; 
        }
        
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return directorsArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
       
        cell.textLabel?.text = directorsArray[indexPath.row]
        
        return cell
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if displayEmails == true {
            let subject = ""
            let body = " "
            
            let email = "mailto:\(emailArray[indexPath.row])?subject=\(subject)&body=\(body)".stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())
            
            if let emailURL:NSURL = NSURL(string: email!)
            {
                if UIApplication.sharedApplication().canOpenURL(emailURL)
                {
                    UIApplication.sharedApplication().openURL(emailURL)
                }
            }
        } else {
            let phoneNumberString = phoneNumbersArray[indexPath.row]
            if let phoneURL = NSURL(string: "tel://\(phoneNumberString)") {
            UIApplication.sharedApplication().openURL(phoneURL)
            }
        }
    }

}
