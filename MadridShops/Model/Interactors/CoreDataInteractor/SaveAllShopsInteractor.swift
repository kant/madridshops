//
//  SaveAllShopsInteractor.swift
//  MadridShops
//
//  Created by Bamby on 18/11/17.
//  Copyright © 2017 Juan S. Landy. All rights reserved.
//

import CoreData

protocol SaveAllShopsInteractor {
    func execute(shops: Shops, context: NSManagedObjectContext, onSuccess: @escaping (Shops) -> Void, onError: errorClosure)
}
