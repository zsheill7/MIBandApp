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
    
    @IBOutlet weak var table: UITableView!
  
    var events = [eventItem]()
    
    let user = PFUser.currentUser()

  

    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*if NSUserDefaults.standardUserDefaults().objectForKey("eventList") != nil {
            eventList = NSUserDefaults.standardUserDefaults().objectForKey("eventList") as! [eventItem]
        }*/
        
        var query1 = PFUser.query()
        
        query1?.findObjectsInBackgroundWithBlock({ (objects, error) in
            if let users = objects {
                self.events.removeAll(keepCapacity: true)
                
            }
            
            var marchingQuery = PFQuery(className: "Event")
            
            
            let userInstrument = PFUser.currentUser()!["marchingInstrument"] as! String
                print(userInstrument)
            
                
                marchingQuery.whereKey("instrument", equalTo: userInstrument)
                marchingQuery.whereKey("ensemble", equalTo: "Marching Band")
                marchingQuery.findObjectsInBackgroundWithBlock({ (objects, error) in
                    
                    if let objects = objects {
                        
                        for object in objects {
                            //seeing if the ensemble is "Marching Band"
                            
                                //print((object["instrument"] as! String) + userInstrument)

                                var newEvent: eventItem = eventItem(title: object["title"] as! String, date: object["date"] as! NSDate, description: object["description"] as! String, instrument: object["instrument"] as! String, ensemble: object["ensemble"] as! String, UUID: "sdfg")
                                
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
                        
                        var newEvent: eventItem = eventItem(title: object["title"] as! String, date: object["date"] as! NSDate, description: object["description"] as! String, instrument: object["instrument"] as! String, ensemble: object["ensemble"] as! String, UUID: "sdfg")
                        
                        self.events.append(newEvent)
                        
                        self.table.reloadData()
                        
                    }
                }
            })

            
            
            
        })
        
        events = events.sort({$0.date.timeIntervalSinceNow > $1.date.timeIntervalSinceNow})
        
        self.table.reloadData()
    
       

        
        
        
        
        
        
    }

    @IBAction func addEvent(sender: AnyObject) {
        var segueString = "memberAddEvent"
        
        
        if let isAdmin = user!["isAdmin"] as? Bool {
            if isAdmin == true {
                segueString = "adminAddEvent"
            }
        }
        
        self.performSegueWithIdentifier(segueString, sender: self)
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
    

    override func viewDidAppear(animated: Bool) {
        table.reloadData()
    }
    
    
   
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            eventList.removeAtIndex(indexPath.row)
            
            //NSUserDefaults.standardUserDefaults().setObject(eventList, forKey: "eventList")
            table.reloadData()
        }
    }


}
