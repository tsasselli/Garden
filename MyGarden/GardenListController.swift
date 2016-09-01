//
//  GardenListController.swift
//  MyGarden
//
//  Created by Travis Sasselli on 9/1/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import UIKit
import CloudKit

public let GardenListControllerDidRefreshNotification = "GardenDetailControllerDidRefreshNotification"


class GardenListController {

    private(set) var garden: [Garden] = [] {
        
        didSet {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let nc = NSNotificationCenter.defaultCenter()
                nc.postNotificationName(GardenListControllerDidRefreshNotification, object: self)
            })
        }
    }
    
  //  func fetchGardenInfo (


}