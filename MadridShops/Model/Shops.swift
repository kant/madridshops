//
//  Shops.swift
//  MadridShops
//
//  Created by Bamby on 28/10/17.
//  Copyright © 2017 Juan S. Landy. All rights reserved.
//

import Foundation

public protocol ShopsProtocol {
    func count() -> Int
    func add(shop:Shop)
    func get(index: Int) -> Shop
}
public class Shops:ShopsProtocol{
    private var shopsList: [Shop]?
    
    public init() {
        self.shopsList = []
    }
    public func count() -> Int {
        return shopsList?.count ?? 0
    }
    
    public func add(shop: Shop) {
        shopsList?.append(shop)
    }
    
    public func get(index: Int) -> Shop {
        return shopsList![index]
    }
    
    
}
