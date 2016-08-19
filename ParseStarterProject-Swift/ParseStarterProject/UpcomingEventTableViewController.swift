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
                      
                        self.events = self.events.sort({$0.date.compare($1.date) == .OrderedAscending})
                        self.table.reloadData()
                        
                        
                    }
                }
            })

            
            
            
        })
        
        
        
    
       

        
        
        
        
        
        
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
    
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    

    
    
   
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            eventList.removeAtIndex(indexPath.row)
            
            //NSUserDefaults.standardUserDefaults().setObject(eventList, forKey: "eventList")
            table.reloadData()
        }
    }


}
