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
    
    func createNewGarden(gdName: String?, gdBio: String?, gdProducts: String?, gdLocation: String?, gdContact: String?, gdPhone: String?, image: UIImage, completion: ((Garden) -> Void)?) {
        guard let imageData: NSData = UIImageJPEGRepresentation(image, 0.8) else { return }
        
        guard let garden = Garden(gdName: gdName, gdBio: gdBio, gdProducts: gdProducts, gdLocation: gdLocation, gdContact: gdContact, gdPhone: gdLocation, profileImgData: imageData, backgroundImgData: imageData, collectionViewImgData: [imageData]) else { return }
        
        guard let record = garden.cloudKitRecord else { return }
        
        self.cloudKitManager.saveRecord(record) { (record, error) in
            guard let record = record else {
                if let error = error {
                    NSLog("Error saving new post to CloudKit: \(error)")
                    return
                }
                completion?(garden)
                return
            }
            garden.cloudKitRecordID = record.recordID
        }
    }
}
