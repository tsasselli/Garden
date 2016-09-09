//
//  GardenAnnotation.swift
//  MyGarden
//
//  Created by Travis Sasselli on 9/9/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import UIKit
import MapKit

class GardenAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init (coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
