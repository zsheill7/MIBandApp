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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let client = TWTRAPIClient()
        self.dataSource = TWTRUserTimelineDataSource(screenName: "@mihsband", APIClient: client)
    }
}
