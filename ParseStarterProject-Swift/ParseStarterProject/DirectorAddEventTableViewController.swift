//
//  ViewController.swift
//  Band App Test
//
//  Created by Zoe Sheill on 6/22/16.
//  Copyright © 2016 ClassroomM. All rights reserved.
//

import UIKit
import Parse



class DirectorAddEventTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var eventType: UIPickerView!
    
    @IBOutlet weak var bandType: UIPickerView!
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var eventDescription: UITextField!
    
    @IBOutlet weak var startDatePicker: UIDatePicker!

    @IBOutlet weak var endDatePicker: UIDatePicker!
    
  
    @IBOutlet weak var ensembleTable: UITableView!
    
    @IBOutlet weak var instrumentTable: UITableView!
    
    var activityIndicator = UIActivityIndicatorView()
    
    let formatter = NSDateFormatter()
    
    
    
    let eventPickerData = ["Marching Band Sectional", "Concert Band Sectional", "Ensemble Rehearsal"]
    let bandTypePickerData = ["Marching Band", "Concert Band"]
    
    var searchActive: Bool = false
    
    var filtered:[String] = []
    
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
    
    
    @IBAction func addEventButton(sender: AnyObject) {
        
        activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
        activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        let pickerEvent = String(eventPickerData[eventType.selectedRowInComponent(0)])
        
        let bandTypeEvent = String(eventPickerData[bandType.selectedRowInComponent(0)])
        
        //let attrString = NSAttributedString(string: dateString, attributes:attributes)
        
        var eventDescriptionText = " "
        if eventDescription.text != nil {
            eventDescriptionText = eventDescription.text!
        }
        //var newEvent: eventItem = eventItem(title: pickerEvent, date: myDatePicker.date, description: eventDescriptionText, UUID: "sdfg")
        
        //eventList.append(newEvent)
        //print(eventList)
        //NSUserDefaults.standardUserDefaults().setObject(eventList, forKey: "eventList")
        
        var event = PFObject(className: "Event")
        
        event["title"] = pickerEvent
        
        
        
        event["date"] = startDatePicker.date
        
        event["endDate"] = endDatePicker.date
        
        event["description"] = eventDescriptionText
        
        /*if pickerEvent == "Marching Band Sectional" {
            event["instrument"] = PFUser.currentUser()!.objectForKey("marchingInstrument")
            event["ensemble"] = "Marching Band"
        } else {
            
            event["instrument"] = PFUser.currentUser()!.objectForKey("concertInstrument")
            event["ensemble"] = PFUser.currentUser()!.objectForKey("concertBandType")
        }*/
        
        //event["instrument"] =
        
        event.saveInBackgroundWithBlock{(success, error) -> Void in
            self.activityIndicator.stopAnimating()
            
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            
            if error == nil {
                
                dispatch_async(dispatch_get_main_queue()) {
                    [unowned self] in
                    self.performSegueWithIdentifier("addEvent", sender: self)
                }
                
            } else {
                self.displayAlert("Could not add event", message: "Please try again later or contact an admin")
            }
        }
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        /*eventType.dataSource = self
        eventType.delegate = self
        
        bandType.dataSource = self
        bandType.delegate = self*/
        
        searchBar.delegate = self
        
    }
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = concertInstrumentsList.filter({ (text) -> Bool in
            let tmp:NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        
        if(filtered.count == 0) {
            searchActive = false
        } else {
            searchActive = true
        }
        self.tableView.reloadData()
        
    }
    
    
    
    
    /*override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == ensembleTable {
            
            
        } else if tableView == instrumentTable {
            
        }
    }*/
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == ensembleTable {
            if searchActive == true {
                return filtered.count
            }
            return bandTypesList.count
            
        } else if tableView == instrumentTable {
            concertInstrumentsList.count
        }
        return 0
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        if tableView == ensembleTable {
            cell.textLabel?.text = String(bandTypesList[indexPath.row])
            
        } else if tableView == instrumentTable {
            
            if searchActive == true {
                cell.textLabel?.text = filtered[indexPath.row]
            } else {
                cell.textLabel?.text = String(concertInstrumentsList[indexPath.row])
            }
        }
        return cell
        
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    
}

