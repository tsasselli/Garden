//
//  Garden.swift
//  MyGarden
//
//  Created by Travis Sasselli on 8/30/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//
import UIKit
import Foundation
import CloudKit

class Garden {
    
    static let typeKey = "Garden"
    static let gdNameKey = "gardenName"
    static let gdBioKey = "gardenBio"
    static let gdProductsKey = "gardenPlants"
    static let gdLocationKey = "gardenLocation"
    static let gdContactKey = "gardenContact"
    static let gdPhoneKey = "gardenPhone"
    static let profileImgKey = "profileImg"
    static let backgroundImgKey = "backgroundImg"
    static let collectViewImgKey = "collectionViewImg"
    static let addressKey = "addressKey"
    
    var gdName: String?
    var gdBio: String?
    var gdProducts: String?
    var gdLocation: CLLocation?
    var gdContact: String?
    var gdPhone: String?
    var gdAddress: String?
    var profileImgData: NSData?
    var gdCreator: User
    
    var profileImg: UIImage? {
        guard let profileImgData = profileImgData else { return nil }
        return UIImage(data: profileImgData)
    }
    var backgroundImgData: NSData?
    
    var backgroundImg: UIImage? {
        guard let backgroundImgData = backgroundImgData else { return nil }
        return UIImage(data: backgroundImgData)
    }
//    var collectViewImgData: NSData?
//    
//    var collectionViewImg: [UIImage]  {
//        guard let collectViewImgData = self.collectViewImgData else { return [] }
//        return [UIImage(data: collectViewImgData)!]
//    }
    
    init(gdName: String?, gdBio: String?, gdProducts: String?, gdLocation: CLLocation?, gdContact: String?, gdPhone: String?,profileImgData: NSData?, backgroundImgData: NSData?, gdAddress: String?, creator: User/* gdRecordID: CKRecordID? ,collectionViewImgData: [NSData]*/) {
        
        self.gdName = gdName
        self.gdBio = gdBio
        self.gdProducts = gdProducts
        self.gdLocation = gdLocation
        self.gdContact = gdContact
        self.gdPhone = gdPhone
        self.profileImgData = profileImgData
        self.backgroundImgData = backgroundImgData
//        self.gdRecordID = gdRecordID
        self.gdAddress = gdAddress
        self.gdCreator = creator
    }
    
    private var temporaryBackgroundPhotoURL: NSURL {
        
        let temporaryDirectory = NSTemporaryDirectory()
        let temporaryDirectoryURL = NSURL(fileURLWithPath: temporaryDirectory)
        let fileURL = temporaryDirectoryURL.URLByAppendingPathComponent(NSUUID().UUIDString).URLByAppendingPathExtension("jpg")
        
        profileImgData?.writeToURL(fileURL, atomically: true)
        backgroundImgData?.writeToURL(fileURL, atomically: true)
        return fileURL
    }
    
    private var temporaryProfilePhotoURL: NSURL {
        
        let temporaryDirectory = NSTemporaryDirectory()
        let temporaryDirectoryURL = NSURL(fileURLWithPath: temporaryDirectory)
        let fileURL = temporaryDirectoryURL.URLByAppendingPathComponent(NSUUID().UUIDString).URLByAppendingPathExtension("jpg")
        
        profileImgData?.writeToURL(fileURL, atomically: true)
        return fileURL
    }
    
   
    
      convenience required init?(record: CKRecord) {
        guard let gdName = record[Garden.gdNameKey] as? String,
            gdBio = record[Garden.gdBioKey] as? String,
            gdProducts = record[Garden.gdProductsKey] as? String,
            gdLocation = record[Garden.gdLocationKey] as? CLLocation?,
            gdContact = record[Garden.gdContactKey] as? String,
            gdPhone = record[Garden.gdPhoneKey] as? String,
            profileImgAsset = record[Garden.profileImgKey] as? CKAsset,
            backgroundImgAsset = record[Garden.backgroundImgKey] as? CKAsset,
            gdAddress = record[Garden.addressKey] as? String,
            creator = record[""] as? User
            /* collectViewImgData = record[Garden.collectViewImgKey] as? [NSData]*/ else {
            print("failable Init failed")
            return nil}
        
        let profilePhotoData = NSData(contentsOfURL: profileImgAsset.fileURL)
        let backroundPhotoData = NSData(contentsOfURL: backgroundImgAsset.fileURL)
       
        self.init(gdName: gdName, gdBio: gdBio, gdProducts: gdProducts, gdLocation: gdLocation, gdContact: gdContact, gdPhone: gdPhone, profileImgData: profilePhotoData, backgroundImgData: backroundPhotoData, gdAddress: gdAddress, creator: creator /* collectionViewImgData: collectViewImgData)*/)
        self.cloudKitRecordID = record.recordID
    }
    
    var cloudKitRecordID: CKRecordID?
    
    var cloudKitRecord: CKRecord? {
        // convert to CKRecord & return
        let record = CKRecord(recordType: Garden.typeKey)
        record[Garden.gdNameKey] = gdName
        record[Garden.gdBioKey] = gdBio
        record[Garden.gdProductsKey] = gdProducts
        record[Garden.gdLocationKey] = gdLocation
        record[Garden.gdContactKey] = gdContact
        record[Garden.gdPhoneKey] = gdPhone
        record[Garden.addressKey] = gdAddress
        record[Garden.profileImgKey] = CKAsset(fileURL: temporaryProfilePhotoURL)
        record[Garden.backgroundImgKey] = CKAsset(fileURL: temporaryBackgroundPhotoURL)
       /* record[Garden.collectViewImgKey] = collectViewImgData */
        
        return record
    }
}


    
    










