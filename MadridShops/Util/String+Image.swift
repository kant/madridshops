//
//  String+Image.swift
//  MadridShops
//
//  Created by Bamby on 15/11/17.
//  Copyright © 2017 Juan S. Landy. All rights reserved.
//

import Foundation
import UIKit

extension String{
    
    func loadImage(into imageView: UIImageView){
        
        DispatchQueue.global().async {
            
            if let url = URL(string: self), let data = NSData(contentsOf: url), let image = UIImage(data: data as Data){
//                data = no utiliza Data porque es una clase de swift y tiene que usar try, catch
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }
    }
    
    
}
