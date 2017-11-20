//
//  DownloadAllShopsFake.swift
//  MadridShops
//
//  Created by Bamby on 28/10/17.
//  Copyright © 2017 Juan S. Landy. All rights reserved.
//

import Foundation

class DownloadAllShopsFake: DownloadAllShopsInteractor{
    func execute(onSuccess: @escaping (Shops) -> Void, onError: errorClosure = nil) {
        let shops = Shops()
        for i in 0...10{
            let shop = Shop(name: "tienda \(i)")
            shop.address = "Madrid \(i)"
            shops.add(shop: shop)
        }
        
        DispatchQueue.main.async {
            onSuccess(shops)
        }
        
    }
    
    
}
