//
//  ListTableViewCell.swift
//  MyGarden
//
//  Created by Travis Sasselli on 9/6/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import UIKit
import QuartzCore

class ListTableViewCell: UITableViewCell {
   
    @IBOutlet weak var backgroundImgView: UIImageView!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var gardenNameLabel: UILabel!

    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        gardenNameLabel.layer.cornerRadius = 10
        profileImgView.layer.cornerRadius = profileImgView.frame.size.width/2
        
        self.profileImgView.layer.borderWidth = 1.5
        
        self.profileImgView.layer.borderColor = UIColor.whiteColor().CGColor
        

        profileImgView.clipsToBounds = true
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

//    func addShadow() {
//        
//        profileImgView.layer.shadowRadius = 5.0
//        profileImgView.layer.shadowColor = UIColor.whiteColor().CGColor
//        //profileImgView.layer.shadowOpacity = 0.1
//        profileImgView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        profileImgView.clipsToBounds = false
//
//    }
//    
//    func maskRoundedImage(image: UIImage, radius: Float) -> UIImage {
//        let imageView: UIImageView = UIImageView(image: image)
//        var layer: CALayer = CALayer()
//        layer = imageView.layer
//        
//        layer.masksToBounds = true
//        layer.cornerRadius = CGFloat(radius)
//        layer.borderWidth = 4.0
//        layer.borderColor = UIColor.whiteColor().CGColor
//        
//        UIGraphicsBeginImageContext(imageView.bounds.size)
//        layer.renderInContext(UIGraphicsGetCurrentContext()!)
//        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        return roundedImage
//    }

    
}
