//
//  ViewController.swift
//  Band App Test
//
//  Created by Zoe Sheill on 6/22/16.
//  Copyright © 2016 ClassroomM. All rights reserved.
//

import UIKit
import Parse

extension NSDate
{
    convenience
    init(dateString:String) {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let d = dateStringFormatter.dateFromString(dateString)!
        self.init(timeInterval:0, sinceDate:d)
    }
}

let eventPickerData = ["Marching Band Sectional", "Concert Band Sectional", "Ensemble Rehearsal", "Reminder"]
let bandTypePickerData = ["Marching Band", "Concert Band"]

class AddEventTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var eventDescription: UITextField!
    
 
    @IBOutlet weak var myDatePicker: UIDatePicker!
    
    @IBOutlet weak var eventType: UIPickerView!
    
    @IBOutlet weak var bandType: UIPickerView!

    var willRepeat = false
    
    var activityIndicator = UIActivityIndicatorView()
    
    let formatter = NSDateFormatter()
    
    
    
    
    
    func displayAlert(title: String, message: String) {
            var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                
            })))
            
            self.presentViewController(alert, animated: true, completion: nil)
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
            var event = PFObject(className: "Event")
            
            event["title"] = pickerEvent
            
            event["date"] = myDatePicker.date
            
            event["description"] = eventDescriptionText
            
            event["willRepeat"] = willRepeat
            
            event["UUID"] = UUID
            
            if pickerEvent == "Marching Band Sectional" {
                let userInstrument = PFUser.currentUser()!.objectForKey("marchingInstrument")
                event.addObject(userInstrument!, forKey: "instrument")
                event.addObject("Marching Band", forKey: "ensemble")
                
            } else {
                
                event["instrument"] = PFUser.currentUser()!.objectForKey("concertInstrument")
                event["ensemble"] = PFUser.currentUser()!.objectForKey("concertBandType")
            }
            
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            
            event.saveInBackgroundWithBlock{(success, error) -> Void in
                self.activityIndicator.stopAnimating()
                
                
                
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
        } else if willRepeat == true {
            let UUID = NSUUID().UUIDString
            
            while placeholderDate.earlierDate(endOfSchool).isEqualToDate(placeholderDate) {
            
                
                var event = PFObject(className: "Event")
                
                event["title"] = pickerEvent
                
                event["date"] = placeholderDate
                
                event["description"] = eventDescriptionText
                
                
                event["willRepeat"] = true
                
                event["UUID"] = UUID
                if pickerEvent == "Marching Band Sectional" {
                    
                let marchingInstrument = PFUser.currentUser()!.objectForKey("marchingInstrument")
                event.addObject(marchingInstrument!, forKey: "instrument")
                 event.addObject("Marching Band", forKey: "ensemble")
                    
                } else {
                    let concertInstrument = PFUser.currentUser()!.objectForKey("concertInstrument") as! String
                    print(concertInstrument)
                    let concertBandType = PFUser.currentUser()!.objectForKey("concertBandType") as! String
                    print("here")
        
                    event.addObject(concertInstrument, forKey: "instrument")
                    event.addObject(concertBandType, forKey: "ensemble")
               
                    
                }
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                event.saveInBackgroundWithBlock{(success, error) -> Void in
                    self.activityIndicator.stopAnimating()
                    
                    
                    
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
            willRepeat = false
            
        }

        

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        eventDescription.delegate = self
        
        
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        eventType.dataSource = self
        eventType.delegate = self
        
        bandType.dataSource = self
        bandType.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
     self.view.endEditing(true)
     return false
     }
    
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
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
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        /*        */
    }
    
    


}

