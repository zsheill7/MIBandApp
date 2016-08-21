//
//  TwitterViewController.swift
//  Nonmember Band App
//
//  Created by Zoe Sheill on 7/24/16.
//  Copyright © 2016 ClassroomM. All rights reserved.
//

import UIKit
import TwitterKit

class TwitterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        // Add a button to the center of the view to show the timeline
        let button = UIButton(type: .System)
        button.setTitle("Show Timeline", forState: .Normal)
        button.sizeToFit()
        button.center = view.center
        button.addTarget(self, action: #selector(showTimeline), forControlEvents: [.TouchUpInside])
        view.addSubview(button)
        
        

    }
    
    
    
    func showTimeline() {
        let client = TWTRAPIClient()
        let dataSource = TWTRUserTimelineDataSource(screenName: "@MIHSBand", APIClient: client)
        let timelineViewControlller = TWTRTimelineViewController(dataSource: dataSource)
        
        
        let navigationController = UINavigationController(rootViewController: timelineViewControlller)
        showDetailViewController(navigationController, sender: self)

            }
    func dismissTimeline() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    
}
