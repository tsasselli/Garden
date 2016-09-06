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
    
    @IBOutlet weak var backgroundTapGesture: UITapGestureRecognizer!
    
    @IBOutlet weak var profileTapGesture: UITapGestureRecognizer!
    
    var imagePicker = UIImagePickerController()
    
    var isFromFirst: Bool = false
    
    var garden: Garden?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        imagePicker.delegate = self
        
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: #selector(gardensWereUpdated), name: addGardenControllerDidRefreshNotification, object: nil)
        
    }
    
    func gardensWereUpdated (){
      
    }
    
    
    @IBAction func createGarden(sender: AnyObject) {
        
        let gardenName = nameTextField.text
        let gardenBio = descriptionTextField.text
        let product = productTextField.text
        let location = LocationTextField.text
        let contact = contactNameTextField.text
        let phone = phoneTextField.text
         let profImg = profileImg.image
         let backgroundImgs = backgroundImg.image
        // let collectionViewImgs = collectionViewImg.image
        
        
        AddGarderController.sharedController.createNewGarden(gardenName, gdBio: gardenBio, gdProducts: product, gdLocation: location, gdContact: contact, gdPhone: phone, profileImgData: profImg!, backgroundImg: backgroundImgs!, /* collectionViewImg: (collectionViewImgs)!*/ completion: { (_) in
            
        })
        dismissViewControllerAnimated(true, completion: nil)
        //         //else {
        //
        //            let alertController = UIAlertController(title: "Missing Garden Information", message: "Please check your info and try again.", preferredStyle: .Alert)
        //            alertController.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
        //
        //            presentViewController(alertController, animated: true, completion: nil)
        //
        //        }
        
    }
    
    
    @IBAction func backgroundImgTapped(sender: AnyObject) {
        self.isFromFirst = true
        presentActionSheet()
    }
    
    
    
    @IBAction func profileImgTapped(sender: AnyObject) {
        self.isFromFirst = false
        
        presentActionSheet()
    }
    
    
    
    
    func presentActionSheet () {
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
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
         guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        
        if self.isFromFirst {
            self.backgroundImg.image = image
        } else {
            profileImg.image = image
        }
        
        dismissViewControllerAnimated(true, completion: nil)

    }
    
    
    
    
    // MARK: - Navigation
    
    
    //     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //
    //
    //     }
    //
    
}
