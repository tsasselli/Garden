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
            print(loggedInUser?.firstName)
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
            guard let record = record else { completion(success: false); return }
            self.currentUserRecordId = record.recordID
            
            let recordID = record.recordID
            
            let predicate = NSPredicate(format: "reference == %@", recordID)
            
            self.cloudKitManager.fetchRecordsWithType(User.typeKey, predicate: predicate, recordFetchedBlock: { (record) in
                self.currentUserRecordId = record.recordID
                guard let currentUserID = self.currentUserRecordId else { return }
                let user = User(record: record)
                user?.record = record
                self.currentUserReference = CKReference(recordID: currentUserID, action: .None)
            }) { (records, error) in
                if error != nil {
                    print("Error fetching current user record: \(error?.localizedDescription)")
                    completion(success: false)
                } else if records?.count == 0 {
                    completion(success: false)
                } else if records?.count > 0 {
                    completion(success: true)
                }
            }
        }
    }
    

    
}