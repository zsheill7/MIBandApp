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

    var pickerFrame: CGRect?
    
    let picker = UIImageView(image: UIImage(named: "Custom Picker View 2"))
    
    
    
    
    
    @IBOutlet weak var calendarWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        let isSubscribed = user!.objectForKey("isSubscribed") as? Bool
      
        if isSubscribed == nil || isSubscribed == false {
            if #available(iOS 8.0, *) {
                var alert = UIAlertController(title: "Enable Google Calendar Notifications", message: "This will automatically notify you of an upcoming event", preferredStyle: UIAlertControllerStyle.Alert)
                
                alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                    
                    if let calendarURL = NSURL(string: "https://calendar.google.com/calendar/ical/u6rtjohvfecm62qv0ad1rfjb54hu09h7%40import.calendar.google.com/public/basic.ics") {
                        UIApplication.sharedApplication().openURL(calendarURL)
                        
                    }
                    self.user!.setObject(true, forKey: "isSubscribed")
                    self.user!.saveInBackground()
                    
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
        /*let html = "<iframe src=\"https://calendar.google.com/calendar/embed?showPrint=0&amp;showTabs=0&amp;showTz=0&amp;mode=AGENDA&amp;height=600&amp;wkst=1&amp;bgcolor=%23FFFFFF&amp;src=u6rtjohvfecm62qv0ad1rfjb54hu09h7%40group.calendar.google.com&amp;color=%232952A3&amp;ctz=America%2FLos_Angeles\" style=\"border-width:0\" width=\"\(screenWidth)\" height=\"\(screenHeight * 2)\" frameborder=\"0\" scrolling=\"no\"></iframe>"*/
        
        let html = "<iframe src=\"https://calendar.google.com/calendar/embed?title=MIHS%20Band&amp;showPrint=0&amp;showTabs=0&amp;showCalendars=0&amp;showTz=0&amp;mode=AGENDA&amp;height=600&amp;wkst=1&amp;bgcolor=%23FFFFFF&amp;src=u6rtjohvfecm62qv0ad1rfjb54hu09h7%40import.calendar.google.com&amp;color=%232952A3&amp;ctz=America%2FLos_Angeles\" style=\"border-width:0\" width=\"\(screenWidth)\" height=\"\(screenHeight * 2)\" frameborder=\"0\" scrolling=\"no\"></iframe>"
        
        //let html = "<iframe src=\"https://www.charmsoffice.com/charms/calendarembed.asp?s=MercerIsHSB\" width=800 height=800></iframe>"
      /* let url = NSURL(string: "https://calendar.google.com/calendar/embed?src=u6rtjohvfecm62qv0ad1rfjb54hu09h7%40import.calendar.google.com&ctz=America/Los_Angeles")
        let request = NSURLRequest(URL: url!)
        calendarWebView.loadRequest(request)*/
        
       calendarWebView.loadHTMLString(html, baseURL: nil)
        self.navigationItem.setHidesBackButton(true, animated: false)
        print( "\(Int(self.calendarWebView.frame.size.width))\\")
        
        calendarWebView.scrollView.scrollEnabled = false
        calendarWebView.scrollView.bounces = false
        
        pickerFrame = CGRect(x: ((self.view.frame.width - picker.frame.size.width) - 10), y: 70, width: 200, height: 160)
        
        createPicker()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BarcodeTableViewController.handleTap(_:)))
        self.view.addGestureRecognizer(gestureRecognizer)
    }
    
    
    
    
    
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        closePicker()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            
            self.performSegueWithIdentifier("goToSettings", sender: self)
        } else if sender.tag == 1 {
            
                        self.performSegueWithIdentifier("goToAboutUs", sender: self)
        } else if sender.tag == 2 {
            
            self.performSegueWithIdentifier("toEmailVC", sender: self)
        }
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        closePicker()
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
