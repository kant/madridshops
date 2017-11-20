//
//  ShopCell.swift
//  MadridShops
//
//  Created by Bamby on 28/10/17.
//  Copyright © 2017 Juan S. Landy. All rights reserved.
//

import UIKit

class ShopCell: UICollectionViewCell {
    
    var shop: Shop?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelOpeningHours: UILabel!
    
    func refresh(theShop: Shop){
        self.shop = theShop
        if getLanguage() == "es"{
            self.labelOpeningHours.text = shop?.openingHours_es
        }else{
            self.labelOpeningHours.text = shop?.openingHours_en
        }
//        self.labelOpeningHours.adjustsFontSizeToFitWidth = true
        self.labelTitle.text = self.shop?.name
        
//        self.shop?.logo.loadImage(into: self.imageView)
        if self.shop?.logoData != nil{
            self.imageView.image = self.shop?.logoData!
        }
    }
}
