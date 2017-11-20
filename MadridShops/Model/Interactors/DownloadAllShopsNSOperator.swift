//
//  DownloadAllShopsNSOperator.swift
//  MadridShops
//
//  Created by Bamby on 29/10/17.
//  Copyright © 2017 Juan S. Landy. All rights reserved.
//

import Foundation

class DownloadAllShopsNSOperator: DownloadAllShopsInteractor{
    func execute(onSuccess: @escaping (Shops) -> Void, onError: errorClosure = nil) {
        //los closures NO EJECUTAN EN BACKGROUND, se tiene que mandar a un hilo secundario
        let queque = OperationQueue()
        queque.addOperation {
            let urlString = "https://madrid-shops.com/json_new/getShops.php"
            
            if let url = URL(string: urlString), let data = NSData(contentsOf: url) as Data?{
                let shops = parseShops(data: data)
                OperationQueue.main.addOperation {
                    onSuccess(shops)
                }
            }
        }
        
    }
    
    
    
}
