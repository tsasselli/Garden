//
//  GardenListViewController.swift
//  MyGarden
//
//  Created by Travis Sasselli on 8/30/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import UIKit

class GardenDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backgroundImageLabel: UIImageView!
    @IBOutlet weak var profImageLabel: UIImageView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var productsLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var garden: Garden?
    
    override func viewDidLoad() {
        
        _ = GardenDetailController()
        
        profImageLabel.layer.cornerRadius = profImageLabel.frame.size.width/2
        profImageLabel.clipsToBounds = true
        

        
        updateWithGarden()
        
    }
    
    func updateWithGarden () {
        if let garden = garden {
            
            
            nameLabel.text = ("Garden Name: \(garden.gdName!)")
            phoneLabel.text = ("Phone Number: \(garden.gdPhone!)")
            contactNameLabel.text = ("Contact Name: \(garden.gdContact!)")
            descriptionLabel.text = ("Description: \(garden.gdBio!)")
            productsLabel.text = ("Products: \(garden.gdProducts!)")
            locationLabel.text = ("Location: \(garden.gdLocation!)")
            backgroundImageLabel.image = garden.backgroundImg
            profImageLabel.image = garden.profileImg
            
        }
    }
      
    //    func requestFullSync(completion: (() -> Void)? = nil) {
    //
    //        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    //
    //        GardenDetailController.sharedController.fetchRecords() {
    //
    //            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    //
    //            if let completion = completion {
    //                completion()
    //            }
    //        }
    //    }
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
