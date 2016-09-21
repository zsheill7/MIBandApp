//
//  DonateViewController.swift
//  Nonmember Band App
//
//  Created by Zoe Sheill on 6/24/16.
//  Copyright © 2016 ClassroomM. All rights reserved.
//

import UIKit

class DonateViewController: UIViewController, UIWebViewDelegate {

    let picker = UIImageView(image: UIImage(named: "Custom Picker View 2"))
    
    var pickerFrame: CGRect?
    
    
    
    
    
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.userInteractionEnabled = true
        // Do any additional setup after loading the view.
        
        /*var html = "<p><a href=\"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&amp;hosted_button_id=XYZRUJWJCF3SN\"><img src=\"https://www.paypal.com/en_US/i/btn/btn_donateCC_LG.gif\" alt=\"\" /></a></p>"
        
        donateWebView.loadHTMLString(html, baseURL: nil)*/
        
        
      let donateHTMLString = "<article id=\"post-69\" class=\"post-69 page type-page status-publish hentry\"> <header class=\"entry-header\"> <h1 class=\"entry-title\">Donate</h1> </header><!-- .entry-header --> <div class=\"entry-content\"> <p>Please donate today to raise money to support and enrich the MISD Band Program.</p> <h1>&#8212; DONATE ONLINE &#8212;</h1> <p><a href=\"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&amp;hosted_button_id=XYZRUJWJCF3SN\"><img src=\"https://www.paypal.com/en_US/i/btn/btn_donateCC_LG.gif\" alt=\"\" /></a></p> <h1>&#8212; WRITE A CHECK &#8212;</h1> <p>Make checks payable to MISBB and mail to P.O. <span style=\"color:#000000;\">Box <span style=\"color:#ff0000;\">1471</span>,</span> Mercer Island, WA 98040</p> <h1></h1> <h1><strong>EVERY DONATION HELPS! </strong></h1> <p><em>The Mercer Island Schools Band Boosters is a non-profit 501(c)(3) corporation, and our tax ID number is 27-4163270. All donations will be acknowledged. More information about MISBB can be found <a title=\"Mercer Island Schools Band Boosters\" href=\"https://misbb.wordpress.com/about/boosters/\">here</a>.</em></p> <p><em>Band Boosters’ funds help provide guest artist workshops, IMS music clubs, one-on-one student support, scholarships, instrument rentals, leadership opportunities, band trip coordination, professional development and community outreach. As a result, band instructors can spend more time in the classroom enriching the musical lives of nearly 1,000 or 40% of Mercer Island 5th – 12th grade students across the district.</em></p> <p><span style=\"text-decoration:underline;color:#0000ff;\"><strong>THANK YOU!</strong></span></p> </div><!-- .entry-content --> <footer class=\"entry-meta\"> </footer><!-- .entry-meta --> </article><!-- #post-69 -->"
            
            
        let url = NSURL(string: "https://misbb.wordpress.com/donate/")
        
        /*let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)*/
        webView.loadHTMLString(donateHTMLString, baseURL: url)
        /*if let url = attemptedUrl {
            
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
        }*/
        
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
            
           
            self.performSegueWithIdentifier("toEmailVC", sender: self)
        }
    }
    @IBAction func homeButtonTapped(sender: AnyObject) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialVC = mainStoryboard.instantiateViewControllerWithIdentifier("initialVC")
        
        self.presentViewController(initialVC, animated: true, completion: nil)
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let url = request.URL where navigationType == UIWebViewNavigationType.LinkClicked{
            UIApplication.sharedApplication().openURL(url)
            return false
        }
        return true
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
