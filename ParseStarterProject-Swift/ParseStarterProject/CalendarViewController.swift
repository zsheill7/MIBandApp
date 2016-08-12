//
//  CalendarViewController.swift
//  Nonmember Band App
//
//  Created by Zoe Sheill on 7/2/16.
//  Copyright © 2016 ClassroomM. All rights reserved.
//

import UIKit
import Parse

class CalendarViewController: UIViewController {
    
    var user = PFUser.currentUser()
    let screenSize: CGRect = UIScreen.mainScreen().bounds

    
    
    @IBOutlet weak var calendarWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let isSubscribed = user?.objectForKey("isSubscribed") as? Bool
      
        if isSubscribed == nil || isSubscribed == false {
            if #available(iOS 8.0, *) {
                var alert = UIAlertController(title: "Enable Google Calendar Notifications", message: "This will automatically notify you of an upcoming event", preferredStyle: UIAlertControllerStyle.Alert)
                
                alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                    
                    if let calendarURL = NSURL(string: "https://calendar.google.com/calendar/ical/0airjflmdkgrtboce2bninip6s%40group.calendar.google.com/public/basic.ics") {
                        UIApplication.sharedApplication().openURL(calendarURL)
                        
                    }
                    self.user?.setObject(true, forKey: "isSubscribed")
                    
                })))
                
                alert.addAction((UIAlertAction(title: "No Thanks", style: .Cancel, handler: { (action) -> Void in
                    
                })))
                
                
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                print("error")
            }
        }
        
        
        
        // Do any additional setup after loading the view.
        let screenWidth = self.view.frame.size.width//screenSize.width
        let screenHeight = self.view.frame.size.height//screenSize.height
        
        print(screenWidth)
        print(screenHeight)
        let html = "<iframe src=\"https://calendar.google.com/calendar/embed?showPrint=0&amp;showTabs=0&amp;showTz=0&amp;mode=AGENDA&amp;height=600&amp;wkst=1&amp;bgcolor=%23FFFFFF&amp;src=0airjflmdkgrtboce2bninip6s%40group.calendar.google.com&amp;color=%232952A3&amp;ctz=America%2FLos_Angeles\" style=\"border-width:0\" width=\"\(screenWidth)\" height=\"\(screenHeight * 2)\" frameborder=\"0\" scrolling=\"no\"></iframe>"
        
        
        calendarWebView.loadHTMLString(html, baseURL: nil)
        self.navigationItem.setHidesBackButton(true, animated: false)
        print( "\(Int(self.calendarWebView.frame.size.width))\\")
        
        calendarWebView.scrollView.scrollEnabled = false
        calendarWebView.scrollView.bounces = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
