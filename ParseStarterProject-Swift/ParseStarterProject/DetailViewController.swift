//
//  DetailViewController.swift
//  AddEventTest
//
//  Created by Zoe on 8/18/16.
//  Copyright © 2016 Zoe. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    @IBOutlet weak var eventTitle: UILabel!

    var eventTitleText = ""
    
    @IBOutlet weak var date: UILabel!
    
    var dateText = ""
  
    @IBOutlet weak var eventDescription: UILabel!
    
    var eventDescriptionText = ""
    
    @IBOutlet weak var instrument: UILabel!
    
    var instrumentText = ""
    
    /*var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }*/

    /*func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }*/

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.configureView()
        
        eventTitle.text = eventTitleText
        date.text = dateText
        eventDescription.text = eventDescriptionText
        instrument.text = instrumentText
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

