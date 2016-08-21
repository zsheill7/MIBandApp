//
//  DonateViewController.swift
//  Nonmember Band App
//
//  Created by Zoe Sheill on 6/24/16.
//  Copyright © 2016 ClassroomM. All rights reserved.
//

import UIKit

class DonateViewController: UIViewController {

    let picker = UIImageView(image: UIImage(named: "Custom Picker View 2"))
    
    var pickerFrame: CGRect?
    
    
    
    
    struct properties {
        static let pickerEvents = [
            ["title" : "Log In", "color" : UIColor.buttonBlue()],
            ["title" : "About Us", "color": UIColor.buttonBlue()],
            ["title" : "Contact Us", "color" : UIColor.buttonBlue()],
            
            ]
    }
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /*var html = "<p><a href=\"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&amp;hosted_button_id=XYZRUJWJCF3SN\"><img src=\"https://www.paypal.com/en_US/i/btn/btn_donateCC_LG.gif\" alt=\"\" /></a></p>"
        
        donateWebView.loadHTMLString(html, baseURL: nil)*/
        
        
      
            
            
        let attemptedUrl = NSURL(string: "https://misbb.wordpress.com/donate/")
        
        if let url = attemptedUrl {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) in
                
                
                
                if let urlContent = data {
                    
                    let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                    
                    let websiteArray = webContent!.componentsSeparatedByString("<div id=\"content\" role=\"main\">")
                    
                    if websiteArray.count > 1 {
                        
                        let upcomingArray = websiteArray[1].componentsSeparatedByString("<div id=\"comments\">")
                        
                        if upcomingArray.count > 1 {
                            
                            
                            let upcomingEvents = upcomingArray[0]
                            print(upcomingEvents)
                            dispatch_async(dispatch_get_main_queue(), {
                                self.webView.loadHTMLString(upcomingEvents, baseURL: nil)
                                print(upcomingEvents)
                            
                            })
                        } else {
                            print("upcomingArray.count <= 1")
                            
                        }
                    } else {
                        print("websiteArray.count <= 1")
                    }
                    
                } else {
                    print("error in block")
                }
            })
            
            
            task.resume()
        } else {
            
            print("error")
        }
        
        pickerFrame = CGRect(x: ((self.view.frame.width - picker.frame.size.width) - 10), y: 70, width: 200, height: 160)
        
        createPicker()
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     
     let picker = UIImageView(image: UIImage(named: "Custom Picker View 2"))
     
     var pickerFrame: CGRect?
    
     
     
     
     struct properties {
     static let pickerEvents = [
     ["title" : "Settings", "color" : UIColor.buttonBlue()],
     ["title" : "About Us", "color": UIColor.buttonBlue()],
     ["title" : "Contact Us", "color" : UIColor.buttonBlue()],
     
     ]
     }
     
     
    pickerFrame = CGRect(x: ((self.view.frame.width - picker.frame.size.width) - 10), y: 70, width: 200, height: 160)
    
    createPicker()
    
     */
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
            
           
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loginNC = mainStoryboard.instantiateViewControllerWithIdentifier("loginNC")
            self.presentViewController(loginNC, animated: true, completion: nil)
        } else if sender.tag == 1 {
            
            
           
            self.performSegueWithIdentifier("goToAboutUs", sender: self)
        } else if sender.tag == 2 {
            
            let subject = "MIHS Band App"
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
