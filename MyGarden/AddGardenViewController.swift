//
//  AddGardenViewController.swift
//  MyGarden
//
//  Created by Travis Sasselli on 9/1/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import UIKit
import MapKit

class AddGardenViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
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
        self.profileImg.layer.borderColor = UIColor.whiteColor().CGColor
        self.profileImg.layer.borderWidth = 4.0
        self.profileImg.layer.masksToBounds = false
        
        imagePicker.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
        
        
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: #selector(gardensWereUpdated), name: addGardenControllerDidRefreshNotification, object: nil)
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    func gardensWereUpdated (){
        
    }
    
    // MARK: Create CloudKit Record Function
    
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
        
        print(location)
        
        guard let newlocation = location else { return }
        
        
        forwardGeoCodeAddress(newlocation) { (location) in
          
            AddGarderController.sharedController.createNewGarden(gardenName, gdBio: gardenBio, gdProducts: product, gdLocation: location, gdContact: contact, gdPhone: phone, profileImgData: profImg!, backgroundImg: backgroundImgs!, /* collectionViewImg: (collectionViewImgs)!*/ completion: { (_) in
                
            })
        }

        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("GardenListViewController") as! GardenListViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
        //         //else {
        //
        //            let alertController = UIAlertController(title: "Missing Garden Information", message: "Please check your info and try again.", preferredStyle: .Alert)
        //            alertController.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
        //
        //            presentViewController(alertController, animated: true, completion: nil)
        //
        //        }
        
    }
    
    //MARK: Forward Geo-Coding
    
    func forwardGeoCodeAddress (address: String, completion: (location: CLLocation?) -> Void   ) {
        let geoCoder = CLGeocoder()
        var location: CLLocation?
        
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            if let placemark = placemarks?.first {
                location = placemark.location
            } else {
                print("\(error?.localizedDescription)")
            }
            completion(location: location)
                
        }
        
    }
    
    // MARK: Gesture and Image Picker Functions
    
    @IBAction func backgroundImgTapped(sender: AnyObject) {
        self.isFromFirst = true
        presentActionSheet()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    
        
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
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
        
        
        if self.isFromFirst {
            self.backgroundImg.image = image
        } else {
            profileImg.image = image
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        
    
        }
   
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
    
    // MARK: Text Field/Keyboard Functions
    
    
    func textFieldShouldReturn (textField: UITextField) -> Bool {
        let textFields = productTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        descriptionTextField.resignFirstResponder()
        contactNameTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
        LocationTextField.resignFirstResponder()
        return textFields
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            let contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.size.height, 0)
            scrollView.contentInset = contentInset
            scrollView.scrollIndicatorInsets = contentInset
            
            scrollView.contentSize = CGSizeMake(scrollView.contentSize.width, scrollView.contentSize.height)
            
            scrollView.scrollRectToVisible((nameTextField.superview?.frame)!, animated: true)
            scrollView.scrollRectToVisible((productTextField.superview?.frame)!, animated: true)
            scrollView.scrollRectToVisible((contactNameTextField.superview?.frame)!, animated: true)
            scrollView.scrollRectToVisible((LocationTextField.superview?.frame)!, animated: true)
            scrollView.scrollRectToVisible((phoneTextField.superview?.frame)!, animated: true)
            scrollView.scrollRectToVisible((descriptionTextField.superview?.frame)!, animated: true)
            
            
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        let contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
        
        scrollView.contentSize = CGSizeMake(scrollView.contentSize.width, scrollView.contentSize.height)
    }
    
    // MARK: - Navigation
    
    
    //     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //
    //
    //     }
    //
}

