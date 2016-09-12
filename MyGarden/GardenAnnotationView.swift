//
//  GardenAnnotationView.swift
//  MyGarden
//
//  Created by Travis Sasselli on 9/12/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import UIKit
import MapKit

class GardenAnnotationView: MKAnnotationView {
    class PizzaAnnotationView: MKAnnotationView {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
        }
        
        override init(annotation: MKAnnotation!, reuseIdentifier: String!) {
            
            super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
            
            var frame = self.frame
            frame.size = CGSizeMake(80, 80)
            self.frame = frame
            self.backgroundColor = UIColor.clearColor()
            self.centerOffset = CGPointMake(-5, -5)
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            
        }
        override func drawRect(rect: CGRect) {
            UIImage(named: "hand.png")?.drawInRect(CGRectMake(30, 30, 30,30))
        }
    }
}