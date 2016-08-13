//
//  InitialViewController.swift
//  ParseBandApp
//
//  Created by Zoe on 8/12/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    let window = UIWindow?()
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var communityButton: UIButton!
    @IBOutlet weak var memberButton: UIButton!
    
    @IBOutlet weak var communityLabel: UIImageView!
    
    @IBOutlet weak var memberLabel: UIImageView!
    override func viewDidLoad() {
        communityButton.contentMode = UIViewContentMode.ScaleAspectFit
        memberButton.contentMode = UIViewContentMode.ScaleAspectFit
        communityLabel.contentMode = UIViewContentMode.ScaleAspectFit
        memberLabel.contentMode = UIViewContentMode.ScaleAspectFit
    }
    @IBAction func communityButtonPressed(sender: AnyObject) {
        let nonmemberStoryboard = UIStoryboard(name: "Nonmember", bundle: nil)
        let initialViewController = nonmemberStoryboard.instantiateViewControllerWithIdentifier("nonmemberTBC") as! UITabBarController
        self.window?.rootViewController = initialViewController
        UIApplication.sharedApplication().keyWindow?.rootViewController = initialViewController
        
        let navigationViewController = initialViewController.viewControllers![3] as! UINavigationController
        let photosViewController = navigationViewController.topViewController as! PhotosViewController
        photosViewController.store = PhotoStore()
        nonmemberStoryboard.instantiateViewControllerWithIdentifier("nonmemberTBC")
        
    }
    
    @IBAction func BandMemberButtonPressed(sender: AnyObject) {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        
        if let isAppAlreadyLaunchedOnce = defaults.stringForKey("isAppAlreadyLaunchedOnce") {
            
            
            let initialViewController = mainStoryboard.instantiateViewControllerWithIdentifier("loginNC") as! UINavigationController
            self.window?.rootViewController = initialViewController
        
            UIApplication.sharedApplication().keyWindow?.rootViewController = initialViewController
            mainStoryboard.instantiateViewControllerWithIdentifier("loginNC")
        } else {
            
            let initialViewController = mainStoryboard.instantiateViewControllerWithIdentifier("createAccountVC")
            self.window?.rootViewController = initialViewController
            UIApplication.sharedApplication().keyWindow?.rootViewController = initialViewController
            mainStoryboard.instantiateViewControllerWithIdentifier("createAccountVC")
            defaults.setBool(true, forKey: "isAppAlreadyLaunchedOnce")
            
        }

    }

}
