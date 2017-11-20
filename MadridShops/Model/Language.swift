//
//  Language.swift
//  MadridShops
//
//  Created by Bamby on 20/11/17.
//  Copyright © 2017 Juan S. Landy. All rights reserved.
//

import Foundation

func getLanguage()->String{
    let language = Locale.preferredLanguages[0]
    
    let index = language.index(of: "-") ?? language.endIndex
    let beginning = language[..<index]
    
    return String(beginning)
    
}
struct Language {
    let id: String
    let name : String
    
}
