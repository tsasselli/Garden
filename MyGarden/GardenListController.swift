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
    
   static let sharedController = GardenListController()
    let cloudKitManager = CloudKitManager()
    
    init () {
    }
    
    private(set) var gardens: [Garden] = [] {
        
        didSet {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let nc = NSNotificationCenter.defaultCenter()
                nc.postNotificationName(GardenListControllerDidRefreshNotification, object: self)
            })
        }
    }
//    
    func fetchGardenListRecords(completion: ((NSError?) -> Void)? = nil) {
        let predicate = NSPredicate(value: true)
        
        cloudKitManager.fetchRecordsWithType(Garden.typeKey, predicate: predicate, recordFetchedBlock: { (record) in
            
        }) { (records, error) in
            if let error = error {
                print(" Error: Unable to fetch Garden record from cloudKit. \(error.localizedDescription)")
                
                return
            }
            
            guard let records = records else { return }
            
                        print(records.description)
            
            self.gardens = records.flatMap { Garden(record: $0) }
            
        }
    }

    
    
    
    
    
    
    
    
    
    
    
//    func fetchGardenListInfo (garden: Garden, completion: () -> Void) {
//        
//        guard let gardenRecordID = garden.gardenRecordID else { completion(); return }
//        
//        let predicate = NSPredicate(format: "Garden == %@", gardenRecordID)
//        
//        cloudKitManager.fetchRecordsWithType(Garden.typeKey, predicate: predicate, recordFetchedBlock: { (record) in
//            //
//        }) { (records, error) in
//            if error != nil {
//                print("Error fetching messages: \(error?.localizedDescription)")
//                completion()
//            } else {
//                dispatch_async(dispatch_get_main_queue()) {
//                    guard let records = records else {
//                        completion()
//                        return
//                    }
//                    
//                    let garden = records.flatMap { Garden(record: $0) }
//                }
//                completion()
//            }
//        }
//    }
//    
    
    
    
    
    //    func fetchGardenInfo (completion: (gardens: [Garden]?) -> Void) {
    //
    //        guard let reference = UserController.sharedController.currentUserReference else { completion(gardens: []); return }
    //        let predicate = NSPredicate(format: "users CONTAINS %@", reference)
    //
    //        cloudKitManager.fetchRecordsWithType(Garden.typeKey, predicate: predicate, recordFetchedBlock: { (record) in
    //            //
    //        }) { (records, error) in
    //            if error != nil {
    //                print("Error fetching gardens for current user: \(error?.localizedDescription)")
    //                completion(gardens: [])
    //            } else {
    //                dispatch_async(dispatch_get_main_queue()) {
    //                    guard let records = records else {
    //                        print("Records are nil")
    //                        completion(gardens: [])
    //                        return
    //                    }
    //                    var gardenArray: [Garden] = []
    //                    for record in records {
    //                        guard let garden = Garden(record: record) else { completion(gardens: []); return }
    //                        self.gardens.append(garden)
    //                        gardenArray.append(garden)
    //                    }
    //                    completion(gardens: gardenArray)
    //                }
    //            }
    //        }
    //    }
}