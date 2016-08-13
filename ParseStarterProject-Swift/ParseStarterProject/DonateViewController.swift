//
//  DonateViewController.swift
//  Nonmember Band App
//
//  Created by Zoe Sheill on 6/24/16.
//  Copyright © 2016 ClassroomM. All rights reserved.
//

import UIKit

class DonateViewController: UIViewController {


    
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
