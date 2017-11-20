//
//  SaveAllShopsImplementation.swift
//  MadridShops
//
//  Created by Bamby on 18/11/17.
//  Copyright © 2017 Juan S. Landy. All rights reserved.
//

import Foundation
import CoreData

class SaveAllShopsImplementation: SaveAllShopsInteractor{
    func execute(shops: Shops, context: NSManagedObjectContext, onSuccess: @escaping (Shops) -> Void, onError: errorClosure) {
        for i in 0..<shops.count(){
            let shop = shops.get(index: i)
            _ = shopToCoreData(shop: shop, context: context)
        }
        
        do{
            try context.save()
            onSuccess(shops)
        }
        catch{
            //error
        }
    }
    
    
}
