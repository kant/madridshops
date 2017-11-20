//
//  JSONParser.swift
//  MadridShops
//
//  Created by Bamby on 29/10/17.
//  Copyright © 2017 Juan S. Landy. All rights reserved.
//

import Foundation
import UIKit
func parseShops(data: Data) -> Shops{
    let shops = Shops()
    do{
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
        let result = jsonObject["result"] as! [NSDictionary]
        
        
        for object in result{
            let shop = Shop(name: object.object(forKey: "name") as? String ?? "")
            shop.address = object.object(forKey: "address") as? String ?? ""
            shop.description_es = object.object(forKey: "description_es") as? String ?? ""
            shop.description_en = object.object(forKey: "description_en") as? String ?? ""
            shop.logo = object.object(forKey: "logo_img") as? String ?? ""
            shop.image = object.object(forKey: "img") as? String ?? ""
            shop.openingHours_es = object.object(forKey: "opening_hours_es") as? String ?? ""
            shop.openingHours_en = object.object(forKey: "opening_hours_en") as? String ?? ""
            shop.latitude = Float(object.object(forKey: "gps_lat") as? String ?? "0.0")
            shop.longitude = Float(object.object(forKey: "gps_lon") as? String ?? "0.0")
            
            let urlImageMap = "https://maps.googleapis.com/maps/api/staticmap?%25&size=320x220&scale=2&markers=\(shop.latitude ?? 0.0),\(shop.longitude ?? 0.0)"
            if let url = URL(string: urlImageMap), let data = NSData(contentsOf: url), let image = UIImage(data: data as Data){
                shop.imageData = image
            }
            
            if let urlLogo = URL(string: shop.logo), let dataLogo = NSData(contentsOf: urlLogo), let imageLogo = UIImage(data: dataLogo as Data){
                shop.logoData = imageLogo
            }
            
            shops.add(shop:shop)
        }
        
    }catch{
        print("error parsing json \(data.debugDescription)")
    }
    return shops
}

