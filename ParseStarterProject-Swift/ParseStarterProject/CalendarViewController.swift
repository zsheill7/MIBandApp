//
//  CalendarViewController.swift
//  Nonmember Band App
//
//  Created by Zoe Sheill on 7/2/16.
//  Copyright © 2016 ClassroomM. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds

    @IBOutlet weak var calendarWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let screenWidth = screenSize.width
        
        var html = "<iframe src=\"https://calendar.google.com/calendar/embed?showPrint=0&amp;showTabs=0&amp;showTz=0&amp;mode=AGENDA&amp;height=600&amp;wkst=1&amp;bgcolor=%23FFFFFF&amp;src=0airjflmdkgrtboce2bninip6s%40group.calendar.google.com&amp;color=%232952A3&amp;ctz=America%2FLos_Angeles\" style=\"border-width:0\" width=\"\(screenWidth)\" height=\"600\" frameborder=\"0\" scrolling=\"yes\"></iframe>"
        print(html)
        
        calendarWebView.loadHTMLString(html, baseURL: nil)
        self.navigationItem.setHidesBackButton(true, animated: false)
        print( "\(Int(self.calendarWebView.frame.size.width))\\")
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
