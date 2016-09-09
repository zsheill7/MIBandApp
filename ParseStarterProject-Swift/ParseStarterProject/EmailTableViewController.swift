//
//  EmailTableViewController.swift
//  MI Band
//
//  Created by Zoe on 9/9/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class EmailTableViewController: UITableViewController {

    let emailArray = ["parker.bixby@mercerislandschools.org", "jen.mcclellan@mercerislandschools.org", "Ryan.Lane@mercerislandschools.org",
                      "Bryan.Wanzer@mercerislandschools.org",
                      "Carol.Krell@mercerislandschools.org",
                      "David.Bentley@mercerislandschools.org"]
    
    let directorsArray =
        ["Parker Bixby",
         "Jen McClellan",
         "Ryan Lane",
         "Bryan Wanzer",
         "Carol Krell",
         "David Bentley"]
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func viewDidLoad() {
        self.title = "Email a Director"
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
        
        
    }
}
