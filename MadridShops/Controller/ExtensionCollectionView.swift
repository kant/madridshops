//
//  ExtensionCollectionView.swift
//  MadridShops
//
//  Created by Bamby on 28/10/17.
//  Copyright © 2017 Juan S. Landy. All rights reserved.
//

import UIKit
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - Delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cells", for: indexPath) as! ShopCell
        let shop = fetchedResultsController.object(at: indexPath)
        cell.refresh(theShop:(shopCoreDataToShop(shopCD: shop)))
        return cell
        
    }
    
    //MARK: - Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.shops?.count() ?? 0
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let shop = self.shops?.get(index: indexPath.row)
        let shop = self.fetchedResultsController.object(at: indexPath)
        performSegue(withIdentifier: "showShopDetailSegue", sender: shop)
    }
    
}
