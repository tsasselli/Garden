//
//  AddGardenViewController.swift
//  MyGarden
//
//  Created by Travis Sasselli on 9/1/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import UIKit

class AddGardenViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
            
            
            AddGarderController.sharedController.createNewGarden(gardenName, gdBio: gardenBio, gdProducts: product, gdLocation: location, gdContact: contact, gdPhone: phone, profileImgData: profImg!, backgroundImg: backgroundImgs!, collectionViewImg: (collectionViewImgs)!, completion: { (_) in
                
            })
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            
            let alertController = UIAlertController(title: "Missing Garden Information", message: "Please check your info and try again.", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
            
            presentViewController(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    
    @IBAction func backgroundImgTapped(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let actionSheet = UIAlertController(title: "choose and Image Source", message: nil, preferredStyle:  .ActionSheet)
        let cancelAction = UIAlertAction(title:"Cancel", style: .Cancel, handler: nil)
        let photoLibaryAction = UIAlertAction(title: "Photo Library", style: .Default) { (_) in
            imagePicker.sourceType = .PhotoLibrary
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        let cameraAction = UIAlertAction (title: "Camera", style: .Default) { (_) in
            imagePicker.sourceType = .Camera
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        let savedPhotosAction = UIAlertAction(title: "Saved Photos", style: .Default) { (_) in
            imagePicker.sourceType = .SavedPhotosAlbum
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        actionSheet.addAction(cancelAction)
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            actionSheet.addAction(cameraAction)
        }
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            actionSheet.addAction(photoLibaryAction)
        }
        if UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum) {
            actionSheet.addAction(savedPhotosAction)
        }
        presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func backgroundImgPickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        backgroundImg.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    
    @IBAction func profileImgTapped(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let actionSheet = UIAlertController(title: "choose and Image Source", message: nil, preferredStyle:  .ActionSheet)
        let cancelAction = UIAlertAction(title:"Cancel", style: .Cancel, handler: nil)
        let photoLibaryAction = UIAlertAction(title: "Photo Library", style: .Default) { (_) in
            imagePicker.sourceType = .PhotoLibrary
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        let cameraAction = UIAlertAction (title: "Camera", style: .Default) { (_) in
            imagePicker.sourceType = .Camera
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        let savedPhotosAction = UIAlertAction(title: "Saved Photos", style: .Default) { (_) in
            imagePicker.sourceType = .SavedPhotosAlbum
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        actionSheet.addAction(cancelAction)
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            actionSheet.addAction(cameraAction)
        }
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            actionSheet.addAction(photoLibaryAction)
        }
        if UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum) {
            actionSheet.addAction(savedPhotosAction)
        }
        presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func profileImgPickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        profileImg.image = image
        dismissViewControllerAnimated(true, completion: nil)
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
