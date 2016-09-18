//
//  InfoTableViewController.swift
//  MI Band
//
//  Created by Zoe on 9/4/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

struct properties {
    static let pickerEvents = [
        ["title" : "Log In as a Member", "color" : UIColor.buttonBlue()],
        ["title" : "About This App", "color": UIColor.buttonBlue()],
        ["title" : "Contact Us", "color" : UIColor.buttonBlue()],
        
        ]
    static let memberPickerEvents = [
        ["title" : "Settings", "color" : UIColor.buttonBlue()],
        ["title" : "About This App", "color": UIColor.buttonBlue()],
        ["title" : "Contact Us", "color" : UIColor.buttonBlue()],
        
        ]
}

class InfoTableViewController: UITableViewController, UIWebViewDelegate{

    
    let picker = UIImageView(image: UIImage(named: "Custom Picker View 2"))
    
    var pickerFrame: CGRect?
    
    
    var rowHeight = 280
    
    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.scrollView.delegate = self
        webView.scrollView.scrollEnabled = false
        let attemptedUrl = NSURL(string: "https://misbb.wordpress.com/about/")
        let HTMLString = "<article id=\"post-2\" class=\"post-2 page type-page status-publish hentry\"><header class=\"entry-header\"><h1 class=\"entry-title\">About</h1></header><!-- .entry-header --> </a>The Mercer Island Band Program is proudly non-competitive and strives for excellence resulting in international awards and performance opportunities. Close to 300 strong, one-in-four high school students and over 700 students district-wide participate in the grade 5-12 band program. Learn more about:</p><ul> <li><a title=\"Bands\" href=\"https://misbb.wordpress.com/about/bands/\">Bands</a></li> <li><a title=\"Directors\" href=\"https://misbb.wordpress.com/about/directors/\">Directors</a></li> <li><a title=\"Student Leadership\" href=\"https://misbb.wordpress.com/about/student-leadership/\">Student Leadership</a></li> <li><a title=\"Awards &amp; Accolades\" href=\"https://misbb.wordpress.com/about/awards-accolades/\">Awards &amp; Accolades</a></li> <li><a title=\"Mercer Island Schools Band Boosters\" href=\"https://misbb.wordpress.com/about/boosters/\">The Mercer Island School Band Boosters</a></li></ul> </div><!-- .entry-content --> <footer class=\"entry-meta\"> </footer><!-- .entry-meta --> </article>"
        
        self.webView.loadHTMLString(HTMLString, baseURL: nil)
        self.webView.delegate = self
        
        self.webView.scrollView.scrollEnabled = false
        if DeviceType.IS_IPAD || DeviceType.IS_IPAD_PRO {
            rowHeight = 510
        }
        pickerFrame = CGRect(x: ((self.view.frame.width - picker.frame.size.width) - 10), y: 15, width: 200, height: 160)
        
        createPicker()
        
        self.view.userInteractionEnabled = true
        self.tableView.backgroundColor = UIColor.whiteColor()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        self.view.addGestureRecognizer(gestureRecognizer)
        
        
    }
    
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        closePicker()
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    @IBAction func pickerSelect(sender: UIBarButtonItem) {
        picker.hidden ? openPicker() : closePicker()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return CGFloat(rowHeight)
            
        }
        
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
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
        if let url = request.URL where navigationType == UIWebViewNavigationType.LinkClicked {
            UIApplication.sharedApplication().openURL(url)
            return false
        }
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        closePicker()
    }

    
}
