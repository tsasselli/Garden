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
            
            //            print(records.description)
            guard let currentLocation = GardenDetailController.locationMannager.location else { return }
            
            
            self.gardens = records.flatMap { Garden(record: $0) }.sort{ $0.0.gdLocation?.distanceFromLocation(currentLocation) < $0.1.gdLocation?.distanceFromLocation(currentLocation)  }
            
            //            let   sortedGardens = gardens.sort({ $0.0.clLocation.distanceFromLocation(self.currentLocation) < $0.1.clLocation?.distanceFromLocation(self.currentLocation) })
            
        }
    }
    
    
    
    //    func deleteRecordWithID(recordID: CKRecordID, completion: ((recordID: CKRecordID?, error: NSError?) -> Void)?) {
    //
    //        publicDatabase.deleteRecordWithID(recordID) { (recordID, error) in
    //            completion?(recordID: recordID, error: error)
    //        }
    //    }
    //
    
    //
    //        func pushChangesToCloudKit(completion: ((success: Bool, error: NSError?) -> Void)?) {
    //
    //            let unsavedGarden = unsyncedRecords(Garden.typeKey) as? [Garden] ?? []
    //            var unsavedObjectsByRecord = [CKRecord: CloudKitSyncable]()
    //            for garden in unsavedGarden {
    //                let record = CKRecord(garden)
    //                unsavedObjectsByRecord[record] = garden
    //            }
    //
    //
    //
    //            let unsavedRecords = Array(unsavedObjectsByRecord.keys)
    //
    //            cloudKitManager.saveRecords(unsavedRecords, perRecordCompletion: { (record, error) in
    //
    //                guard let record = record else { return }
    //                unsavedObjectsByRecord[record]?.cloudKitRecordID = record.recordID
    //
    //            }) { (records, error) in
    //
    //                let success = records != nil
    //                completion?(success: success, error: error)
    //            }
    //        }
    
    //    // MARK: HELPER Functions
    //
    //
    private func recordsOfType(type: String) -> [CloudKitSyncable] {
        switch type {
        case "Garden":
            return gardens.flatMap { $0 as? CloudKitSyncable }
        default:
            return []
        }
    }
    
    func unsyncedRecords(type: String) -> [CloudKitSyncable] {
        return recordsOfType(type).filter { !$0.isSynced }
    }
    
    
    
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









