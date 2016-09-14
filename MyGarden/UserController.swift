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
    
    func createNewUsers(completion: () -> Void) {
        cloudKitManager.fetchLoggedInUserRecord { (record, error) in
            guard let record = record else { completion(); return }
            self.currentUserRecordId = record.recordID
            guard let userRecordID = self.currentUserRecordId else { completion(); return }
            
            self.currentUserReference = CKReference(recordID: userRecordID, action: .None)
            
            self.cloudKitManager.fetchUsernameFromRecordID(userRecordID, completion: { (givenName, familyName) in
                guard let firstName = givenName,
                    lastName = familyName,
                    reference = self.currentUserReference else {
                        completion()
                        return
                }
                
                let userRecord = CKRecord(recordType: User.referenceKey)
                userRecord.setValue(firstName, forKey: User.firstNameKey)
                userRecord.setValue(lastName, forKey: User.lastNameKey)
                userRecord.setValue(reference, forKey: User.referenceKey)
                
                self.cloudKitManager.saveRecord(userRecord, completion: { (_, error) in
                    if error != nil {
                        print("Error saving current user record to cloudKit: \(error?.localizedDescription)")
                        completion()
                    }
                    print("Successfully saved new user to cloudKit.")
                    completion()
                })
            })
        }
    }
    
    func fetchCurrentUserRecord(completion: (success: Bool) -> Void) {
        
        cloudKitManager.fetchLoggedInUserRecord { (record, error) in
            guard let record = record else { completion(success: false)
                print("Error: No record Found")
                return }
            self.currentUserRecordId = record.recordID
            
            let recordID = record.recordID
            
            let predicate = NSPredicate(format: "reference == %@", recordID)
            
            self.cloudKitManager.fetchRecordsWithType(User.typeKey, predicate: predicate, recordFetchedBlock: { (record) in
                self.currentUserRecordId = record.recordID
                guard let currentUserID = self.currentUserRecordId else {print("Error: No current user found"); return }
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
