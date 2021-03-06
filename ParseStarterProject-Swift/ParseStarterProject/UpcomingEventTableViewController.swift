//
//  SecondViewController.swift
//  Band App Test
//
//  Created by Zoe Sheill on 6/23/16.
//  Copyright © 2016 ClassroomM. All rights reserved.
//

import UIKit
import Parse

var eventList = [eventItem]()


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
class EventTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nagivationItem: UINavigationItem!
    @IBOutlet weak var table: UITableView!
  

   
    
    var instruments:[String] = []
    var ensembles:[String] = []
    var events = [eventItem]()
    
    var user = PFUser.currentUser()

    var refresher: UIRefreshControl!
    var detailVC: DetailViewController? = nil

    let picker = UIImageView(image: UIImage(named: "Custom Picker View 2"))
    
    var pickerFrame: CGRect?
    
    var willRepeat = false
    
    var activityIndicator = UIActivityIndicatorView()
    
    
    
    
    
    
    func displayAlert(title: String, message: String) {
        
       
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dismissKeyboard()
       
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: #selector(EventTableViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        table.addSubview(refresher)
        refresher.endRefreshing()
       // self.hideKeyboardWhenTappedAround()
        navigationItem.hidesBackButton = true
        
        var isAdmin = user!["isAdmin"] as! Bool
        
        reloadTableData()

        
        pickerFrame = CGRect(x: ((self.view.frame.width - picker.frame.size.width) - 10), y: 70, width: 200, height: 160)
        
        createPicker()
        
        self.view.endEditing(true)
        
        
    }
    func refresh(sender:AnyObject) {
        reloadTableData()
    }
    
    func reloadTableData() {
        let query1 = PFUser.query()
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailVC = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        query1?.findObjectsInBackgroundWithBlock({ (objects, error) in
            if objects != nil {
                self.events.removeAll(keepCapacity: true)
                
            }
            
            if let isAdmin = self.user!["isAdmin"] as? Bool {
            
                let marchingQuery = PFQuery(className: "Event")
                
                
                let userInstrument = PFUser.currentUser()!["marchingInstrument"] as! String
           
                
                
                if isAdmin == false  {
                    marchingQuery.whereKey("instrument", equalTo: userInstrument)
                    marchingQuery.whereKey("ensemble", equalTo: "Marching Band")
                }
                
                marchingQuery.findObjectsInBackgroundWithBlock({ (objects, error) in
                    
                    if let objects = objects {
                        
                        for object in objects {
                            //seeing if the ensemble is "Marching Band"
                            
                            //print((object["instrument"] as! String) + userInstrument)
                            
                            
                            let ensembleCount = object["ensemble"].count
                            
                            var instrumentMatch = false
                            self.instruments = object["instrument"] as! [String]
                            var instrumentCount = self.instruments.count
                            
                            var instrumentMatchIndex = 0
                            
                            if  instrumentCount > 1 {
                                for (index, instrumentString) in self.instruments.enumerate() {
                                    if instrumentString == userInstrument {
                                        instrumentMatch = true
                                        instrumentMatchIndex = index
                                    }
                                }
                            }
                            
                            var eventInstrument = ""
                            if isAdmin == false{
                                eventInstrument = self.instruments[instrumentMatchIndex]
                            } else {
                                
                            }
                      
                           
                            let newEvent: eventItem = eventItem(title: object["title"] as! String, date: object["date"] as! NSDate, description: object["description"] as! String, instrument: self.instruments[instrumentMatchIndex] , ensemble: "Marching Band", willRepeat: object["willRepeat"] as! Bool, UUID: object["UUID"] as! String, objectID: object.objectId!)
                            
                            
                            self.events.append(newEvent)
                            
                            self.table.reloadData()
                            
                        }
                    }
                })
            }
            
            var concertQuery = PFQuery(className: "Event")
            
            let userConcertInstrument = PFUser.currentUser()!["concertInstrument"] as! String
            
            if let isAdmin = self.user!["isAdmin"] as? Bool {
                
                if isAdmin == false  {
                    concertQuery.whereKey("instrument", equalTo: userConcertInstrument)
                    concertQuery.whereKey("ensemble", notEqualTo: "Marching Band")
                }
                
                concertQuery.findObjectsInBackgroundWithBlock({ (objects, error) in
                    
                    if let objects = objects {
                        
                        for object in objects {
                            //seeing if the ensemble is "Marching Band"
                            
                            //print((object["instrument"] as! String) + userInstrument)
                            
                        
                            
                           
                            
                            var instrumentMatch = false
                            var ensembleMatch = false
                            self.instruments = object["instrument"] as! [String]
                            self.ensembles = object["ensemble"] as! [String]
                            var instrumentCount = self.instruments.count
                            var ensembleCount = self.ensembles.count
                            
                            var instrumentMatchIndex = 0
                            var ensembleMatchIndex = 0
                            let userInstrument = PFUser.currentUser()!["marchingInstrument"] as! String
                            let userEnsemble = PFUser.currentUser()!["concertBandType"] as! String
                            
                            if  instrumentCount > 1 {
                                for (index, instrumentString) in self.instruments.enumerate() {
                                    if instrumentString == userInstrument {
                                        instrumentMatch = true
                                        instrumentMatchIndex = index
                                    }
                                }
                            }
                            
                            if ensembleCount > 1 {
                                for (index, ensembleString) in self.ensembles.enumerate() {
                                    if ensembleString == userEnsemble {
                                        ensembleMatch = true
                                        ensembleMatchIndex = index
                                    }
                                }
                            }
                            
                            var newEvent: eventItem = eventItem(title: object["title"] as! String, date: object["date"] as! NSDate, description: object["description"] as! String, instrument: self.instruments[instrumentMatchIndex], ensemble: self.ensembles[ensembleMatchIndex], willRepeat: object["willRepeat"] as! Bool, UUID: object["UUID"] as! String, objectID: object.objectId!)
                            
                            self.events.append(newEvent)
                            
                            self.events = self.events.sort({$0.date.compare($1.date) == .OrderedAscending})
                            self.table.reloadData()
                            
                            
                        }
                    }
                })
            }
            
            
            
            
        })

        refresher.endRefreshing()
    }
    
 
    @IBAction func addEvent(sender: AnyObject) {
        
        
        if let isSectionLeader = user!["isSectionLeader"] as? Bool {
            if isSectionLeader == true {
                let segueString = "sectionLeaderAdd"
                self.performSegueWithIdentifier(segueString, sender: self)
                
            } else if let isAdmin = user!["isAdmin"] as? Bool {
                if isAdmin == true {
                    let segueString = "adminAdd"
                    self.performSegueWithIdentifier(segueString, sender: self)
                    
                } else {
                    self.displayAlert("Permission Required", message: "You need to be a section leader or administrator to add events")
                    
                }
                
            }
        }
        
        
        
        
        
        
        
        
    }
    
   
    override func viewDidAppear(animated: Bool) {
        table.reloadData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "eventCell") as! eventCell
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as! eventCell
        
        //print(eventList[indexPath.row])
        cell.eventTitle.text = events[indexPath.row].title + " ~ " + events[indexPath.row].instrument
        cell.eventDate.text = events[indexPath.row].getDateString()
        cell.eventDescription.text = events[indexPath.row].description
        
        
        return cell
    }
    
    
   /* func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }*/
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if !(DeviceType.IS_IPAD || DeviceType.IS_IPAD_PRO) {
            self.performSegueWithIdentifier("showDetail", sender: self)
        }
    }
    

    
    
   
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            if user!["isSectionLeader"] as! Bool == false && user!["isAdmin"] as! Bool == false {
                displayAlert("Unable to Delete", message: "You must be a section leader or admin to delete events")
            } else {
            
            activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
            activityIndicator.backgroundColor = UIColor(white: 1, alpha: 0.5)
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            
            
    
            
            if events[indexPath.row].willRepeat == false {
                
                view.addSubview(activityIndicator)
                activityIndicator.startAnimating()
                UIApplication.sharedApplication().beginIgnoringInteractionEvents()
                
                var query = PFQuery(className: "Event")
                query.whereKey("objectID", equalTo: events[indexPath.row].objectID)
                query.findObjectsInBackgroundWithBlock({ (objects, error) in
                    if error == nil {
                        
                        for object in objects! {
                            object.deleteInBackgroundWithBlock({ (success, error) in
                                if (success) {
                                    print("success")
                                } else {
                                    print("unable to delete")
                                }
                            })
                        }
                    } else {
                        print(error)
                    }
                })
                
                
                events.removeAtIndex(indexPath.row)
                
                self.reloadTableData()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                self.activityIndicator.stopAnimating()
            } else /*if events[indexPath.row].willRepeat == true*/{
                var alert = UIAlertController(title: "Delete Repeating Events", message: "Do you want to only delete this event or delete all events in this series?", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Just this event", style: UIAlertActionStyle.Default, handler: { (action) in
                    
                    self.view.addSubview(self.activityIndicator)
                    self.activityIndicator.startAnimating()
                    UIApplication.sharedApplication().beginIgnoringInteractionEvents()
                    
                    var query = PFQuery(className: "Event")
                    
                    query.whereKey("objectID", equalTo: self.events[indexPath.row].objectID)
                    query.findObjectsInBackgroundWithBlock({ (objects, error) in
                        if error == nil {
                            for object in objects! {
                                object.deleteInBackground()
                            }
                        } else {
                            print(error)
                        }
                    })
                    self.events.removeAtIndex(indexPath.row)
                    self.table.reloadData()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    self.activityIndicator.stopAnimating()
                }))
                alert.addAction(UIAlertAction(title: "All events in series", style: UIAlertActionStyle.Default, handler: { (action) in
                    
                    self.view.addSubview(self.activityIndicator)
                    self.activityIndicator.startAnimating()
                    UIApplication.sharedApplication().beginIgnoringInteractionEvents()
                    
                    var query = PFQuery(className: "Event")
                    let currentUUID = self.events[indexPath.row].UUID
                    
                    query.whereKey("UUID", equalTo: currentUUID)
                    query.findObjectsInBackgroundWithBlock({ (objects, error) in
                        if error == nil {
                            for object in objects! {
                                object.deleteInBackground()
                            }
                            
                            
                            UIApplication.sharedApplication().endIgnoringInteractionEvents()
                            self.activityIndicator.stopAnimating()
                        } else {
                            print(error)
                        }
                    })
                    
                    for event in self.events {
                        if event.UUID == currentUUID {
                            self.events.removeAtIndex(self.events.indexOf({ (event) -> Bool in
                                return true
                            })!)
                        }
                    }
                    //self.reloadTableData()
                    self.table.reloadData()
                    
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (action) in
                    
                }))
                self.presentViewController(alert, animated: true, completion: nil)
            
            }
            
            
            //NSUserDefaults.standardUserDefaults().setObject(eventList, forKey: "eventList")
            table.reloadData()
            }
        }
    }
    
    
    
    @IBAction func pickerSelect(sender: UIBarButtonItem) {
        picker.hidden ? openPicker() : closePicker()
    }
    
    
    func createPicker()
    {
        picker.frame = self.pickerFrame!
        picker.alpha = 0
        picker.hidden = true
        picker.userInteractionEnabled = true
        
        var offset = 18
        
        for (index, event) in properties.memberPickerEvents.enumerate()
        {
            let button = UIButton()
            
            button.frame = CGRect(x: 0, y: offset, width: 200, height: 40)
            button.setTitleColor(event["color"] as? UIColor, forState: .Normal)
            button.setTitleColor(UIColor.blueColor(), forState: .Highlighted)
            button.setTitle(event["title"] as? String, forState: .Normal)
            button.tag = index
            
            button.userInteractionEnabled = true
            
            button.addTarget(self, action: #selector(BarcodeTableViewController.pickerButtonTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            picker.addSubview(button)
            
            
            offset += 44
            
        }
        view.addSubview(picker)
        
    }
    
    func openPicker()
    {
        self.picker.hidden = false
        
        UIView.animateWithDuration(0.3) {
            self.picker.frame = self.pickerFrame!
            self.picker.alpha = 1
        }
    }
    
    func closePicker()
    {
        UIView.animateWithDuration(0.3,
                                   animations: {
                                    self.picker.frame = self.pickerFrame!
                                    self.picker.alpha = 0
            },
                                   completion: { finished in
                                    self.picker.hidden = true
            }
        )
    }
    
    func pickerButtonTapped(sender: UIButton!) {
        
        closePicker()
        if sender.tag == 0 {
            print("here")
            /*let settingsVC = storyboard?.instantiateViewControllerWithIdentifier("settingsNC")
             self.presentViewController(settingsVC!, animated: true, completion: nil)*/
            self.performSegueWithIdentifier("goToSettings", sender: self)
        } else if sender.tag == 1 {
            
            
            /*let aboutUsVC = storyboard?.instantiateViewControllerWithIdentifier("aboutUsVC")
             self.presentViewController(aboutUsVC!, animated: true, completion: nil)*/
            self.performSegueWithIdentifier("goToAboutUs", sender: self)
        } else if sender.tag == 2 {
            
                       self.performSegueWithIdentifier("toEmailVC", sender: self)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        closePicker()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            
            
            let detailNC = segue.destinationViewController as! UINavigationController
            let detailVC = detailNC.topViewController as! DetailViewController
            if let indexPath = self.table.indexPathForSelectedRow {
                detailVC.eventTitleText = events[indexPath.row].title
                detailVC.dateText = events[indexPath.row].getDateString()
                detailVC.eventDescriptionText = events[indexPath.row].description
                detailVC.instrumentText = events[indexPath.row].instrument
            }
        }
        
        
    }



}
