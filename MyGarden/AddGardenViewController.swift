//
//  AddGardenViewController.swift
//  MyGarden
//
//  Created by Travis Sasselli on 9/1/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import UIKit

class AddGardenViewController: UIViewController {
    
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var productTextField: UITextField!
    @IBOutlet weak var LocationTextField: UITextField!
    @IBOutlet weak var contactNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var collectionViewImg: UIImageView!
    
    var garden: Garden?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createGarden(sender: AnyObject) {
        
        if let garden = self.garden {
            let gardenName = nameTextField.text
            let gardenBio = descriptionTextField.text
            let product = productTextField.text
            let location = LocationTextField.text
            let contact = contactNameTextField.text
            let phone = phoneTextField.text
            let profImg = profileImg.image
            let backgroundImgs = backgroundImg.image
            let collectionViewImgs = collectionViewImg.image
                
                
                AddGarderController.sharedController.createNewGarden(gardenName, gdBio: gardenBio, gdProducts: product, gdLocation: location, gdContact: contact, gdPhone: phone, profileImgData: <#T##UIImage#>, backgroundImgData: <#T##UIImage#>, collectionViewImgData: <#T##UIImage#>, completion: <#T##((Garden?) -> Void)?##((Garden?) -> Void)?##(Garden?) -> Void#>)
                
            }
            dismissViewControllerAnimated(true, completion: nil)
        } else {
        print ("No garden info was added")
        
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
