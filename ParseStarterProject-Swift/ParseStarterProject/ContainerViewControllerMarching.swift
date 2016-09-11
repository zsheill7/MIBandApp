//
//  ContainerViewControllerOne.swift
//  ParseBandApp
//
//  Created by Zoe on 8/2/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class ContainerViewControllerOne: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var user = PFUser.currentUser()

    @IBOutlet weak var marchingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        marchingTableView.delegate = self
        marchingTableView.dataSource = self
 
        self.marchingTableView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
       /* if segue.identifier == "tableViewEmbed" {
            let myTableViewController = segue.destinationViewController as! UITableViewController
            let marchingTableView = myTableViewController.marchingTableView
            
        }*/
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marchingInstrumentsList.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        //print(concertInstrumentsList[indexPath.row])
        
        
        cell.textLabel?.text = String(marchingInstrumentsList[indexPath.row])
        return cell
        
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        let cellText:String = currentCell.textLabel!.text!
        
   
        user!.setObject(cellText, forKey: "marchingInstrument")
    
        user!.saveInBackground()
        
    }

}
