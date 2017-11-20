//
//  Shop.swift
//  MadridShops
//
//  Created by Bamby on 28/10/17.
//  Copyright © 2017 Juan S. Landy. All rights reserved.
//

import Foundation
import UIKit

public class Shop{
    var name:String
    var description_en: String = ""
    var description_es: String = ""
    var latitude: Float? = nil
    var longitude: Float? = nil
    var image: String = ""
    var logo: String = ""
    var openingHours_en: String = ""
    var openingHours_es: String = ""
    var address: String = ""
    var imageData: UIImage?
    var logoData: UIImage?
    public init(name: String) {
        self.name = name
    }
    
}
