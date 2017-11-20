//
//  MapPin.swift
//  MadridShops
//
//  Created by Bamby on 20/11/17.
//  Copyright © 2017 Juan S. Landy. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
//    var subtitle: String?
    var shop: ShopCoreData?
    var logo: UIImage?
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
