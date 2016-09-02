//
//  GardenDetailController.swift
//  MyGarden
//
//  Created by Travis Sasselli on 8/30/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import UIKit
import CloudKit

public let GardenDetailControllerDidRefreshNotification = "GardenDetailControllerDidRefreshNotification"

class GardenDetailController {
    
    static let sharedController = GardenDetailController()
    private let cloudKitManager = CloudKitManager()
    
    private(set) var garden: [Garden] = [] {
        
        didSet {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let nc = NSNotificationCenter.defaultCenter()
                nc.postNotificationName(GardenDetailControllerDidRefreshNotification, object: self)
            })
        }
    }
    
    func fetchNewRecords(completion: ((NSError?) -> Void)? = nil) {
        let predicate = NSPredicate(value: true)
        
        cloudKitManager.fetchRecordsWithType(Garden.typeKey, predicate: predicate, recordFetchedBlock: { (_) in
            
        }) { (records, error) in
            if let error = error {
                print(" Error: Unable to fetch garden info from cloudKit. \(error.localizedDescription)")
                return
            }
            guard let records = records else { return }
            
            self.garden = records.flatMap { Garden(record: $0) }
        }
    }
}





