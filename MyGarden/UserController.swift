//
//  UserController.swift
//  MyGarden
//
//  Created by Travis Sasselli on 8/30/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import UIKit
import CloudKit

public let UserControllerDidRefreshNotification = "UserControllerDidRefreshNotification"

class UserController {
    
    static let sharedController = UserController()
    private let cloudKitManager = CloudKitManager()
    
    var currentUserRecordId: CKRecordID?
    var currentUserReference: CKReference?
    var users: [User] = []
    
    private(set) var loggedInUser: User? {
        didSet {
            print("if there is a first name it will be on the next line")
            print(loggedInUser)
        }
    }
    
    private(set) var user: [User] = [] {
        didSet {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let nc = NSNotificationCenter.defaultCenter()
                nc.postNotificationName(UserControllerDidRefreshNotification, object: self)
            })
        }
    }
    
    func fetchCurrentUserRecord(completion: (success: Bool) -> Void) {
        
        cloudKitManager.fetchLoggedInUserRecord { (record, error) in
            guard let record = record else { completion(success: false);
                return
            }
            print(record.recordID)
            //self.currentUserRecordId = record.recordID
            
            let recordID = record.recordID
            
            //let predicate = NSPredicate(format: "reference == %@", recordID)
            
            self.cloudKitManager.fetchRecordWithID(recordID, completion: { (record, error) in
                if error != nil {
                    print("Error fetching current user record: \(error?.localizedDescription)")
                    completion(success: false)
                } else if let record = record {
                    print("\n\n\n\n\n\n\n\n\n\nWe have a record: \(record)")
                    let user = User(record: record)
                    self.loggedInUser = user
                }
            
            })
            
            //            self.cloudKitManager.fetchRecordsWithType(User.typeKey, predicate: predicate, recordFetchedBlock: { (record) in
            //                self.currentUserRecordId = record.recordID
            //                guard let currentUserID = self.currentUserRecordId else {
            //                    return
            //                }
            //                let user = User(record: record)
            //
            //                user?.record = record
            //                self.loggedInUser = user
            //                self.currentUserReference = CKReference(recordID: currentUserID, action: .None)
            //            }) { (records, error) in
            //
            //            }
        }
    }
    
    
    
}