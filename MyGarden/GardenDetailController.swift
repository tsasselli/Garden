//
//  GardenDetailController.swift
//  MyGarden
//
//  Created by Travis Sasselli on 8/30/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import UIKit
import CloudKit
import MapKit

public let GardenDetailControllerDidRefreshNotification = "GardenDetailControllerDidRefreshNotification"

class GardenDetailController {
    
    
    init () {
        
        fetchRecords()
        
    }
    
    static let locationMannager = CLLocationManager()
    static let sharedController = GardenDetailController()
    private let cloudKitManager = CloudKitManager()
    var isSyncing: Bool = false
    
    private(set) var gardens: [Garden] = [] {
        
        didSet {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let nc = NSNotificationCenter.defaultCenter()
                nc.postNotificationName(GardenDetailControllerDidRefreshNotification, object: self)
            })
        }
    }
    
    func fetchRecords(completion: ((NSError?) -> Void)? = nil) {
        let predicate = NSPredicate(value: true)
        
        cloudKitManager.fetchRecordsWithType(Garden.typeKey, predicate: predicate, recordFetchedBlock: { (record) in
            
        }) { (records, error) in
            if let error = error {
                print(" Error: Unable to fetch Garden record from cloudKit. \(error.localizedDescription)")
                
                return
            }
            
            guard let records = records else { return }

            guard let currentLocation = GardenDetailController.locationMannager.location else { return }
            
            self.gardens = records.flatMap { Garden(record: $0) }.sort{ $0.0.gdLocation?.distanceFromLocation(currentLocation) < $0.1.gdLocation?.distanceFromLocation(currentLocation)  }
            
        }
    }
    
    
    func deleteRecord (garden: Garden?, completion: ((NSError?) -> Void)? = nil) {
        guard let garden = garden, record = garden.cloudKitRecordID else { return }
        
        cloudKitManager.deleteRecordWithID(record) { (recordID, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("successfully deleted record.")
            }
            completion?(error)
        }
    }
    
    
    
    
    
}









