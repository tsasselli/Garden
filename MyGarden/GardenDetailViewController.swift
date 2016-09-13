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
        
       profImageLabel.layer.cornerRadius = profImageLabel.frame.size.width/2.0
        self.profImageLabel.layer.borderWidth = 1.5
        self.profImageLabel.layer.borderColor = UIColor.whiteColor().CGColor
        

        profImageLabel.clipsToBounds = true
    
        updateWithGarden()
        
    }
   
    func updateWithGarden () {
        if let garden = garden {

            nameLabel.text = ("Garden Name: \(garden.gdName ?? "NO Garden Name Found")")
            phoneLabel.text = ("Phone Number: \(garden.gdPhone ?? "No phone number found")")
            contactNameLabel.text = ("Contact Name: \(garden.gdContact ?? "No Contact Information Found")")
            descriptionLabel.text = ("Description: \(garden.gdBio ?? "NO description fetched")")
            productsLabel.text = ("Products: \(garden.gdProducts ?? "No products fetched")")
            locationLabel.text = ("Location: \(garden.gdAddress ?? "No Address Availble")")
            backgroundImageLabel.image = garden.backgroundImg
            profImageLabel.image = garden.profileImg
            
        }
    }
      
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
