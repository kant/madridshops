//
//  ShopDetailViewController.swift
//  MadridShops
//
//  Created by Bamby on 29/10/17.
//  Copyright © 2017 Juan S. Landy. All rights reserved.
//

import UIKit

class ShopDetailViewController: UIViewController {

    @IBOutlet weak var imageShop: UIImageView!
    @IBOutlet weak var textShop: UITextView!
    
    var shop : Shop?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var detailShop = ""
        if getLanguage() == "es"{
            detailShop = "\(shop?.name ?? "") \n\n \(shop?.description_es ?? "") \n\n \(shop?.openingHours_es ?? "") \n\n \(shop?.address ?? "")"
        }else{
            detailShop = "\(shop?.name ?? "") \n\n \(shop?.description_en ?? "") \n\n \(shop?.openingHours_en ?? "") \n\n \(shop?.address ?? "")"
        }
        self.textShop.text = detailShop
        self.title = shop?.name
//        self.shop?.image.loadImage(into: imageShop)
        
        if self.shop?.imageData != nil{
            self.imageShop.image = self.shop?.imageData!
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
