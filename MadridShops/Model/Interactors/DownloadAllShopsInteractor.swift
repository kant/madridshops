//
//  DownloadAllShopsInteractor.swift
//  MadridShops
//
//  Created by Bamby on 28/10/17.
//  Copyright © 2017 Juan S. Landy. All rights reserved.
//

import Foundation


protocol DownloadAllShopsInteractor {
    func execute(onSuccess: @escaping (Shops) -> Void, onError: errorClosure)
}
