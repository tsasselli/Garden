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
    
    init () {
        
    fetchRecords()

        
    }
    
    static let sharedController = GardenDetailController()
    private let cloudKitManager = CloudKitManager()
    var isSyncing: Bool = false

    
    private(set) var garden: [Garden] = [] {
        
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
            
//            print(records.description)
            
            self.garden = records.flatMap { Garden(record: $0) }
            
        }
    }
    
    // need this function to query just for location data from the cloud 
    
    
    
    func fetchLocationRecords(completion: () -> Void)  {
        var gardens: Garden?
        
       guard let gardenLocation = gardens!.gdLocation else { completion(); return }
        let predicate = NSPredicate(format: "gardenLocation == %@", gardenLocation)
        
        cloudKitManager.fetchRecordsWithType(Garden.typeKey, predicate: predicate, recordFetchedBlock: { (record) in
            
        }) { (records, error) in
            if let error = error {0
                print(" Error: Unable to fetch Garden record from cloudKit. \(error.localizedDescription)")
                
                return
            }
            
            guard let records = records else { return }
            
            print(records.description)
            
            self.garden = records.flatMap { Garden(record: $0) }
            
        }
    }
    

//
//    func pushChangesToCloudKit(completion: ((success: Bool, error: NSError?) -> Void)?) {
//        
//        let unsavedPosts = unsyncedRecords(Garden.typeKey) as? [Garden] ?? []
//        var unsavedObjectsByRecord = [CKRecord: CloudKitSyncable]()
//        for garden in unsavedPosts {
//            let record = CKRecord(garden)
//            unsavedObjectsByRecord[record] = garden
//        }
//        
//        
//        
//        let unsavedRecords = Array(unsavedObjectsByRecord.keys)
//        
//        cloudKitManager.saveRecords(unsavedRecords, perRecordCompletion: { (record, error) in
//            
//            guard let record = record else { return }
//            unsavedObjectsByRecord[record]?.cloudKitRecordID = record.recordID
//            
//        }) { (records, error) in
//            
//            let success = records != nil
//            completion?(success: success, error: error)
//        }
//    }
//
//    // MARK: HELPER Functions
//    
//    
//    private func recordsOfType(type: String) -> [CloudKitSyncable] {
//        switch type {
//        case "Garden":
//            return garden.flatMap { $0 as! CloudKitSyncable }
//            default:
//            return []
//        }
//    }
//
//    
//    
//    func unsyncedRecords(type: String) -> [CloudKitSyncable] {
//        return recordsOfType(type).filter { !$0.isSynced }
//    }
//
//
//func performFullSync(completion: (() -> Void)? = nil) {
//    
//    guard !isSyncing else {
//        completion?()
//        return
//    }
//    
//    isSyncing = true
//    
//    pushChangesToCloudKit { (success) in
//        
//        self.fetchRecords(Garden) {
//            
//                self.isSyncing = false
//                
//                completion?()
//            }
//        }
//    }
    
}







