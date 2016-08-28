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


class EventTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nagivationItem: UINavigationItem!
    @IBOutlet weak var table: UITableView!
  

    var events = [eventItem]()
    
    var user = PFUser.currentUser()

    var detailVC: DetailViewController? = nil

    let picker = UIImageView(image: UIImage(named: "Custom Picker View 2"))
    
    var pickerFrame: CGRect?
    
    
    
    
    
    struct properties {
        static let pickerEvents = [
            ["title" : "Settings", "color" : UIColor.buttonBlue()],
            ["title" : "About Us", "color": UIColor.buttonBlue()],
            ["title" : "Suggest a Change", "color" : UIColor.buttonBlue()],
            
            ]
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*if NSUserDefaults.standardUserDefaults().objectForKey("eventList") != nil {
            eventList = NSUserDefaults.standardUserDefaults().objectForKey("eventList") as! [eventItem]
        }*/
        print("here")
        navigationItem.hidesBackButton = true
        
        let query1 = PFUser.query()
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailVC = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        query1?.findObjectsInBackgroundWithBlock({ (objects, error) in
            if let users = objects {
                self.events.removeAll(keepCapacity: true)
                
            }
            
            let marchingQuery = PFQuery(className: "Event")
            
            
            let userInstrument = PFUser.currentUser()!["marchingInstrument"] as! String
                print(userInstrument)
            
                
                marchingQuery.whereKey("instrument", equalTo: userInstrument)
                marchingQuery.whereKey("ensemble", equalTo: "Marching Band")
                marchingQuery.findObjectsInBackgroundWithBlock({ (objects, error) in
                    
                    if let objects = objects {
                        
                        for object in objects {
                            //seeing if the ensemble is "Marching Band"
                            
                                //print((object["instrument"] as! String) + userInstrument)

                                var newEvent: eventItem = eventItem(title: object["title"] as! String, date: object["date"] as! NSDate, description: object["description"] as! String, instrument: object["instrument"] as! String, ensemble: object["ensemble"] as! String, willRepeat: object["willRepeat"] as! Bool)
                                
                                self.events.append(newEvent)
                                
                                self.table.reloadData()
                            
                        }
                    }
                })
            
            var concertQuery = PFQuery(className: "Event")
            
            let userConcertInstrument = PFUser.currentUser()!["concertInstrument"] as! String
            
            
            concertQuery.whereKey("instrument", equalTo: userConcertInstrument)
            concertQuery.whereKey("ensemble", notEqualTo: "Marching Band")
            concertQuery.findObjectsInBackgroundWithBlock({ (objects, error) in
                
                if let objects = objects {
                    
                    for object in objects {
                        //seeing if the ensemble is "Marching Band"
                        
                        //print((object["instrument"] as! String) + userInstrument)
                        
                        var newEvent: eventItem = eventItem(title: object["title"] as! String, date: object["date"] as! NSDate, description: object["description"] as! String, instrument: object["instrument"] as! String, ensemble: object["ensemble"] as! String, object["willRepeat"] as! Bool)
                        
                        self.events.append(newEvent)
                      
                        self.events = self.events.sort({$0.date.compare($1.date) == .OrderedAscending})
                        self.table.reloadData()
                        
                        
                    }
                }
            })

            
            
            
        })
        
        
        
    
       

        
        
        pickerFrame = CGRect(x: ((self.view.frame.width - picker.frame.size.width) - 10), y: 70, width: 200, height: 160)
        
        createPicker()
        
        
        
    }

    @IBAction func addEvent(sender: AnyObject) {
        var segueString = "sectionLeaderAdd"
        
        
        if let isAdmin = user!["isAdmin"] as? Bool {
            if isAdmin == true {
                segueString = "adminAdd"
            }
        }
        
        self.performSegueWithIdentifier(segueString, sender: self)
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
        cell.eventTitle.text = events[indexPath.row].title + " " + events[indexPath.row].instrument
        cell.eventDate.text = events[indexPath.row].getDateString()
        cell.eventDescription.text = events[indexPath.row].description
        
        
        return cell
    }
    
    
   /* func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }*/
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showDetail", sender: self)
    }
    

    
    
   
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            eventList.removeAtIndex(indexPath.row)
            
            //NSUserDefaults.standardUserDefaults().setObject(eventList, forKey: "eventList")
            table.reloadData()
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
        
        for (index, event) in properties.pickerEvents.enumerate()
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
            
            let subject = "Suggested Changes/Bug fixes to MIHS Band App"
            let body = " "
            
            let email = "mailto:zsheill7@gmail.com?subject=\(subject)&body=\(body)".stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())
            
            if let emailURL:NSURL = NSURL(string: email!)
            {
                if UIApplication.sharedApplication().canOpenURL(emailURL)
                {
                    UIApplication.sharedApplication().openURL(emailURL)
                }
            }
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
