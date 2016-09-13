//
//  AddGardenController.swift
//  MyGarden
//
//  Created by Travis Sasselli on 8/30/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import UIKit
import CloudKit

public let addGardenControllerDidRefreshNotification = "AddGardenControllerDidRefreshNotification"
public let addGardenControllerChangedNotification = "GardenCommentsChangedNotification"

class AddGarderController {
    
    static let sharedController = AddGarderController()
    private let cloudKitManager = CloudKitManager()
    
    private(set) var garden: [Garden] = [] {
        
        didSet {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let nc = NSNotificationCenter.defaultCenter()
                nc.postNotificationName(addGardenControllerDidRefreshNotification, object: self)
            })
        }
    }
    
    func createNewGarden(gdName: String?, gdBio: String?, gdProducts: String?, gdLocation: CLLocation?, gdContact: String?, gdPhone: String?, profileImgData: UIImage, backgroundImg: UIImage, gdAddress: String?, /*collectionViewImg: UIImage,*/ completion: ((Garden?) -> Void)?) {
        guard let profImageData: NSData = UIImageJPEGRepresentation(profileImgData, 0.4),
            backgroundImgData: NSData = UIImageJPEGRepresentation(backgroundImg, 0.6) else { print ("Unable to create image data"); return  }
//                  collectionViewImgData: NSData = UIImageJPEGRepresentation(collectionViewImg, 0.8) else { return }
//      
        guard let currentUser = UserController.sharedController.loggedInUser else {
            return
        }
        
            
    
        let garden = Garden(gdName: gdName, gdBio: gdBio, gdProducts: gdProducts, gdLocation: gdLocation, gdContact: gdContact, gdPhone: gdPhone, profileImgData: profImageData, backgroundImgData: backgroundImgData, gdAddress: gdAddress, creator: currentUser /*collectionViewImgData: [collectionViewImgData])*/ )
        
        guard let record = garden.cloudKitRecord else { print(" Error no record created"); return }
        
        self.cloudKitManager.saveRecord(record) { (record, error) in
            guard let record = record else {
                if let error = error {
                    NSLog("Error saving new post to CloudKit: \(error)")
                }
                
                completion?(nil)
                return
            }
            garden.cloudKitRecordID = record.recordID
            completion?(garden)
        }
    }
    
    
}