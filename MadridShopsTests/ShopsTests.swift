//
//  ShopsTests.swift
//  MadridShopsTests
//
//  Created by Bamby on 28/10/17.
//  Copyright © 2017 Juan S. Landy. All rights reserved.
//

import XCTest
import MadridShops

//@testable import MadridShops
class ShopsTests: XCTestCase {
    
    func testGivenEmptyShopsNumberShopsIsZero(){
        let sut = Shops()
        XCTAssertEqual(0, sut.count())
    }
    
    func testGivenEmptyShopsWithOneElementNumberShopsIsZero(){
        let shops = Shops()
        shops.add(shop: Shop(name: "tienda 1"))
        XCTAssertEqual(0, shops.count())
    }
    
}
