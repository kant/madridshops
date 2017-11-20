//
//  MainViewController.swift
//  MadridShops
//
//  Created by Bamby on 28/10/17.
//  Copyright © 2017 Juan S. Landy. All rights reserved.
//

import UIKit
import PKHUD
import CoreData
import IMNetworkReachability

class MainViewController: UIViewController {
    var context: NSManagedObjectContext!
    let defaults = UserDefaults.standard
    var shops : Shops?
    let reachability = IMNetworkReachability("www.google.com")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        HUD.show(.label("Downloading shops \n Please wait for it  😎"))
        if isInternetOn(){
            if defaults.bool(forKey: "saved"){
               //already saved
                HUD.hide(animated: true)
            }else{
                
                let downloadShopsInteractor: DownloadAllShopsInteractor = DownloadAllShopsNSURLSession()
                downloadShopsInteractor.execute(onSuccess: { (shops: Shops) in
                    self.shops = shops
                    let coreDataInteractor = SaveAllShopsImplementation()
                    coreDataInteractor.execute(shops: shops, context: self.context, onSuccess: { (shops:Shops) in
                        self.defaults.set(true, forKey: "saved")
                        self.defaults.synchronize()
                        HUD.hide(animated: true)
                        HUD.flash(.success, delay: 1.0)
                    }, onError: { (error:Error) in
                        
                    })
                    
                }) { (error: Error) in
                    
                }
            }
        }else{
            HUD.hide(animated: true)
            showMessage(title: "No internet", message: "Please check your internet connection.")
        }
        
    }

    func isInternetOn() -> Bool{
        switch reachability.isReachable() {
        case .reachable:
            print("Reachable")
            return true
        case .offline:
            print("Offline")
            return false
        case .error(let error):
            print("Failed to check for a network reachability, error: \(error)")
            return false

        }
        
    }
    func showMessage(title: String, message: String){
        let errorAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler:nil)
        errorAlert.addAction(defaultAction)
        self.present(errorAlert, animated: true, completion: nil)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation

    @IBAction func showShops(_ sender: UIButton) {
        if defaults.bool(forKey: "saved"){
            performSegue(withIdentifier: "fromMainToView", sender: nil)
        }
        
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "fromMainToView", let vc = segue.destination as? ViewController{
            vc.context = self.context
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
        }
    }
    

}
