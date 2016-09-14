//
//  User.swift
//  MyGarden
//
//  Created by Travis Sasselli on 8/30/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import Foundation
import CloudKit

class User {
    
    static let typeKey = "User"
    static let firstNameKey = "firstName"
    static let lastNameKey = "lastName"
    static let referenceKey = "reference"
    
    var firstName: String?
    var lastName: String?
    var reference: CKReference
    var record: CKRecord?
    
    
    init?(firstName: String?, lastName: String?, reference: CKReference, record: CKRecord){
        self.firstName = firstName
        self.lastName = lastName
        self.reference = reference
        self.record = record
    }
    
    var cloudKitRecordID: CKRecordID?
    var recordType: String { return Garden.typeKey }
    
    convenience init?(record: CKRecord) {
        guard let firstName = record[User.firstNameKey] as? String,
            lastName = record[User.lastNameKey] as? String,
            reference = record[User.referenceKey] as? CKReference else { return nil }
        
        self.init(firstName: firstName, lastName: lastName, reference: reference, record: record)
    }
    
}
