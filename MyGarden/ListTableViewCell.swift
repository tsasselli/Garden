//
//  ListTableViewCell.swift
//  MyGarden
//
//  Created by Travis Sasselli on 9/6/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
   
    @IBOutlet weak var backgroundImgView: UIImageView!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var gardenNameLabel: UILabel!

    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        profileImgView.layer.cornerRadius = profileImgView.frame.size.width/2
        profileImgView.clipsToBounds = true
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

}
