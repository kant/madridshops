//
//  MapShops.swift
//  MadridShops
//
//  Created by Bamby on 18/11/17.
//  Copyright © 2017 Juan S. Landy. All rights reserved.
//

import Foundation
import CoreData
import UIKit

func shopCoreDataToShop(shopCD: ShopCoreData) -> Shop{
    //CoreData -> Shop
    let shop = Shop(name: shopCD.name ?? "tienda")
    shop.name = shopCD.name ?? ""
    shop.description_es = shopCD.description_es ?? ""
    shop.description_en = shopCD.description_en ?? ""
    shop.address = shopCD.address ?? ""
    shop.logo = shopCD.logo ?? ""
    shop.image = shopCD.image ?? ""
    shop.latitude = shopCD.latitude
    shop.longitude = shopCD.longitude
    shop.openingHours_es = shopCD.openingHours_es ?? ""
    shop.openingHours_en = shopCD.openingHours_en ?? ""
    if let dataImage = shopCD.imageData{
        shop.imageData = UIImage(data: dataImage)
    }
    if let dataLogo = shopCD.logoData{
        shop.logoData = UIImage(data: dataLogo)
    }
    return shop
}

func shopToCoreData(shop: Shop, context: NSManagedObjectContext) -> ShopCoreData{
    //shop -> CoreData
    let shopCD = ShopCoreData(context: context)
    shopCD.name = shop.name
    shopCD.description_en = shop.description_en
    shopCD.description_es = shop.description_es
    shopCD.address = shop.address
    shopCD.logo = shop.logo
    shopCD.image = shop.image
    shopCD.latitude = shop.latitude ?? 0.0
    shopCD.longitude = shop.longitude ?? 0.0
    shopCD.openingHours_en = shop.openingHours_en
    shopCD.openingHours_es = shop.openingHours_es
    if let imageData:Data = UIImagePNGRepresentation(shop.imageData ?? #imageLiteral(resourceName: "madrid")){
        shopCD.imageData = imageData
    }
    if let logoData:Data = UIImagePNGRepresentation(shop.logoData ?? #imageLiteral(resourceName: "madrid")){
        shopCD.logoData = logoData
    }
    return shopCD
}
