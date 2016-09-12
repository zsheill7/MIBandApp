//
//  AdminAddEventOneTableViewController.swift
//  MI Band
//
//  Created by Zoe on 9/11/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

import Parse

class AdminAddEventOneTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

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

    
    var activityIndicator = UIActivityIndicatorView()
    
    var event: PFObject!
    
    @IBOutlet weak var myDatePicker: UIDatePicker!
    
    @IBOutlet weak var eventType: UIPickerView!
    
    @IBOutlet weak var bandType: UIPickerView!
    
       @IBOutlet weak var eventDescription: UITextField!
    
    var willRepeat = false
    let formatter = NSDateFormatter()
    
    var instruments:[String] = []
    var ensembles:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        event = PFObject(className: "Event")
        self.tableView.userInteractionEnabled = true
        eventDescription.delegate = self
        
        
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        eventType.dataSource = self
        eventType.delegate = self
        
        bandType.dataSource = self
        bandType.delegate = self
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
        let cal = NSCalendar.currentCalendar()
        var placeholderDate = myDatePicker.date
        
        let calendar = NSCalendar.init(calendarIdentifier: NSCalendarIdentifierGregorian)
        let currentYearInt = Int((calendar?.component(NSCalendarUnit.Year, fromDate: NSDate()))!)
        let currentMonthInt = (calendar?.component(NSCalendarUnit.Month, fromDate: NSDate()))!
        var endOfSchoolYear: Int?
        
        print(currentYearInt)
        print(currentMonthInt)
        print(willRepeat)
        
        if currentMonthInt > 6 {
            endOfSchoolYear = currentYearInt + 1
        } else {
            endOfSchoolYear  = currentYearInt
        }
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let endOfSchool = NSDate(dateString: "\(endOfSchoolYear!)-06-20")
        
        if willRepeat == false {
            
            let UUID = NSUUID().UUIDString
            
            
            event["title"] = pickerEvent
            
            event["date"] = myDatePicker.date
            
            event["description"] = eventDescriptionText
            
            event["willRepeat"] = willRepeat
            
            event["UUID"] = UUID
            
           
                event["instrument"] = instruments
                event["ensemble"] = ensembles
                
            
            
            event.saveInBackgroundWithBlock{(success, error) -> Void in
                self.activityIndicator.stopAnimating()
                
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                if error == nil {
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        [unowned self] in
                        //self.performSegueWithIdentifier("addEvent", sender: self)
                        let VC = self.storyboard?.instantiateViewControllerWithIdentifier("tabBarController")
                        self.presentViewController(VC!, animated: true, completion: nil)
                    }
                    
                } else {
                    self.displayAlert("Could not add event", message: "Please try again later or contact an admin")
                }
            }
        } else /*if willRepeat == true*/ {
            let UUID = NSUUID().UUIDString
            
            while placeholderDate.earlierDate(endOfSchool).isEqualToDate(placeholderDate) {
                
                
                var event = PFObject(className: "Event")
                
                event["title"] = pickerEvent
                
                event["date"] = placeholderDate
                
                event["description"] = eventDescriptionText
                
                
                event["willRepeat"] = willRepeat
                
                event["UUID"] = UUID
                if pickerEvent == "Marching Band Sectional" {
                    event["instrument"] = /*PFUser.currentUser()!.objectForKey("marchingInstrument")*/ instruments
                    event["ensemble"] = "Marching Band"
                    
                } else {
                    
                    event["instrument"] = /*PFUser.currentUser()!.objectForKey("concertInstrument")*/ instruments
                    event["ensemble"] = /*PFUser.currentUser()!.objectForKey("concertBandType")*/ ensembles
                }
                
                event.saveInBackgroundWithBlock{(success, error) -> Void in
                    self.activityIndicator.stopAnimating()
                    
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if error == nil {
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            [unowned self] in
                            //self.performSegueWithIdentifier("addEvent", sender: self)
                            let VC = self.storyboard?.instantiateViewControllerWithIdentifier("tabBarController")
                            self.presentViewController(VC!, animated: true, completion: nil)
                        }
                        
                    } else {
                        self.displayAlert("Could not add event", message: "Please try again later or contact an admin")
                    }
                }
                placeholderDate = cal.dateByAddingUnit(.Day, value: 7, toDate: placeholderDate, options: [])!
                
            }
            
        }
        

        
    }
    
    
    @IBAction func moreSettingsPressed(sender: AnyObject) {
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var segueID = segue.identifier
        
        /*if segueID! == "toInstrument" {
            var instrumentVC = segue.destinationViewController as! AdminAddEventInstrumentTableViewController
            instrumentVC.event = self.event
        } else if segueID! == "toEnsemble" {
            var ensembleVC = segue.destinationViewController as!
            AdminAddEventEnsembleTableViewController
        }*/
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("here")
        if indexPath.section == 0 && indexPath.row == 0 {
            self.performSegueWithIdentifier("toEnsemble", sender: self)
            
        } else if indexPath.section == 0 && indexPath.row == 1 {
            self.performSegueWithIdentifier("toInstrument", sender: self)
        }
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.section != 0 {
            return false
        }
        return true
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == eventType {
            return eventPickerData.count
        }
        return bandTypePickerData.count
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == eventType {
            return eventPickerData[row]
        }
        return bandTypePickerData[row]
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
