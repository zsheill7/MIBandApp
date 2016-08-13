//
//  UpcomingEventsViewController.swift
//  Nonmember Band App
//
//  Created by Zoe on 8/4/16.
//  Copyright © 2016 ClassroomM. All rights reserved.
//

import UIKit

class UpcomingEventsViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let attemptedUrl = NSURL(string: "https://misbb.wordpress.com/")
       
        if let url = attemptedUrl {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) in
                
                
                
                if let urlContent = data {
                    
                    let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                    
                    let websiteArray = webContent!.componentsSeparatedByString("<a href=\"https://misbb.wordpress.com/2016/05/19/mihs-marching-band-raincoat-drive/#respond\"><span class=\"leave-reply\">Reply</span></a>")
                    
                    if websiteArray.count > 1 {
                        
                        let upcomingArray = websiteArray[1].componentsSeparatedByString("<hr />")
                        
                        if upcomingArray.count > 1 {
                           
                            
                            let upcomingEvents = upcomingArray[0]
                            
                            dispatch_async(dispatch_get_main_queue(), {
                                self.webView.loadHTMLString(upcomingEvents, baseURL: nil)
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
