//
//  SearchTimelineViewController.swift
//  Nonmember Band App
//
//  Created by Zoe on 8/3/16.
//  Copyright © 2016 ClassroomM. All rights reserved.
//

import UIKit
import TwitterKit

class SearchTimelineViewController: TWTRTimelineViewController {
    
    let picker = UIImageView(image: UIImage(named: "Custom Picker View 2"))
    
    var pickerFrame: CGRect?
    
    
    
    
    
    
    
    override func viewDidLoad() {
        self.view.userInteractionEnabled = true
        
        super.viewDidLoad()
        
        let client = TWTRAPIClient()
        self.dataSource = TWTRUserTimelineDataSource(screenName: "@mihsband", APIClient: client)
        
        pickerFrame = CGRect(x: ((self.view.frame.width - picker.frame.size.width) - 10), y: 15, width: 200, height: 160)
        
        createPicker()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        self.view.addGestureRecognizer(gestureRecognizer)
    }
    
    
    


    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        closePicker()
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
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        closePicker()
    }
}
