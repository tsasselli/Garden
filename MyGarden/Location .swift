//
//  Location .swift
//  MyGarden
//
//  Created by Travis Sasselli on 9/12/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import Foundation
import MapKit

class Locatoin {
    var latitude: Double
    var longitude: Double
    
    init (longitude: Double, latitude: Double) {
        self.longitude = longitude
        self.latitude = latitude
    }
    
    var clLocation: CLLocation? {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}