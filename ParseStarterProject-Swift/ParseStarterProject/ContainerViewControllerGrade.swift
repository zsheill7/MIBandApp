//
//  ContainerViewControllerOne.swift
//  ParseBandApp
//
//  Created by Zoe on 8/2/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class ContainerViewControllerGrade: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var user = PFUser.currentUser()
    
    @IBOutlet weak var gradeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradeTableView.delegate = self
        gradeTableView.dataSource = self
        
        self.gradeTableView.reloadData()
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
        return gradeList.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        //print(concertInstrumentsList[indexPath.row])
        
        
        cell.textLabel?.text = String(gradeList[indexPath.row])
        return cell
        
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        let cellText:String = currentCell.textLabel!.text!
        
        
        user!.setObject(cellText, forKey: "grade")
        
        user!.saveInBackground()
        
    }
    
}
