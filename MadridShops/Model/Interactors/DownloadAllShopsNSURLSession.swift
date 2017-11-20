//
//  DownloadAllShopsNSURLSession.swift
//  MadridShops
//
//  Created by Bamby on 29/10/17.
//  Copyright © 2017 Juan S. Landy. All rights reserved.
//

import Foundation

class DownloadAllShopsNSURLSession: DownloadAllShopsInteractor {
    func execute(onSuccess: @escaping (Shops) -> Void, onError: errorClosure) {
        let session = URLSession.shared
        if let url = URL(string: "https://madrid-shops.com/json_new/getShops.php"){
            let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                OperationQueue.main.addOperation {
                    if error != nil{
                        print(error?.localizedDescription ?? "error DownloadAllShopsNSURLSession")
                    }else{
                        onSuccess(parseShops(data: data!))
                        
                    }
                }
                
            })
            task.resume()
        }
    }
    
    
}
