//
//  GardenImageCollectionViewCell.swift
//  MyGarden
//
//  Created by Travis Sasselli on 9/13/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import UIKit

class GardenImageCollectionViewCell: UICollectionViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var gardenCollectViewImage: UIImageView!
    
    @IBAction func addImageButtonTapped(sender: AnyObject) {
        
        
    }
    
    func presentActionSheet () {
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        let actionSheet = UIAlertController(title: "choose and Image Source", message: nil, preferredStyle:  .ActionSheet)
//        let cancelAction = UIAlertAction(title:"Cancel", style: .Cancel, handler: nil)
//        let photoLibaryAction = UIAlertAction(title: "Photo Library", style: .Default) { (_) in
//            imagePicker.sourceType = .PhotoLibrary
//            self.presentViewController(imagePicker, animated: true, completion: nil)
//        }
//        let cameraAction = UIAlertAction (title: "Camera", style: .Default) { (_) in
//            imagePicker.sourceType = .Camera
//            self.presentViewController(imagePicker, animated: true, completion: nil)
//        }
//        let savedPhotosAction = UIAlertAction(title: "Saved Photos", style: .Default) { (_) in
//            imagePicker.sourceType = .SavedPhotosAlbum
//            self.presentViewController(imagePicker, animated: true, completion: nil)
//        }
//        actionSheet.addAction(cancelAction)
//        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
//            actionSheet.addAction(cameraAction)
//        }
//        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
//            actionSheet.addAction(photoLibaryAction)
//        }
//        if UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum) {
//            actionSheet.addAction(savedPhotosAction)
//        }
//        presentViewController(actionSheet, animated: true, completion: nil)
//    }
//    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            
//            
//                       
//            dismissViewControllerAnimated(true, completion: nil)
//            
//            
//        }
//        
//        func imagePickerControllerDidCancel(picker: UIImagePickerController) {
//            dismissViewControllerAnimated(true, completion: nil)
//        }
//    }
//    

    
}
