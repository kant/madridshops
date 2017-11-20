//
//  ViewController.swift
//  MadridShops
//
//  Created by Bamby on 27/10/17.
//  Copyright © 2017 Juan S. Landy. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate {

    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    var context : NSManagedObjectContext!
    let defaults = UserDefaults()
    var shops : Shops?
    @IBOutlet weak var collectionShops: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let downloadShopsInteractor: DownloadAllShopsInteractor = DownloadAllShopsFake()
//        let downloadShopsInteractor: DownloadAllShopsInteractor = DownloadAllShopsNSOperator()
//        let downloadShopsInteractor: DownloadAllShopsInteractor = DownloadAllShopsNSURLSession()
        
        if defaults.value(forKey: "saved") != nil{
            self.collectionShops.delegate = self
            self.collectionShops.dataSource = self
        }
//        else{
//            downloadShopsInteractor.execute(onSuccess: { (shops: Shops) in
//                //todo ok
//                self.shops = shops
//
//                let coreDataInteractor = SaveAllShopsImplementation()
//                coreDataInteractor.execute(shops: shops, context: self.context, onSuccess: { (shops:Shops) in
//                    //una vez que graba en CoreData entonces carga collectionView
//                    self.defaults.setValue(true, forKey: "saved")
//                    self.defaults.synchronize()
//                    self.collectionShops.delegate = self
//                    self.collectionShops.dataSource = self //self porque ExtensionCollectionView es un extension de esta vista y ahí están los delegate y datasource
//
//                }, onError: { (error:Error) in
//                    //
//                })
//
//            }) { (error: Error) in
//                //error
//            }
//        }
        
        
       //map
        self.locationManager.requestWhenInUseAuthorization()
        //para tener actualizaciones de la ubicación del dispositivo
//        self.locationManager.delegate = self
//        self.locationManager.startUpdatingLocation()
        
        let madridLocation = CLLocation(latitude: 40.4384, longitude: -3.6970)
//        let cuencaLocation = CLLocation(latitude: -2.8922671, longitude: -79.0594206)
//        self.mapView.setCenter(madridLocation.coordinate, animated: true)
        
        let region = MKCoordinateRegion(center: madridLocation.coordinate, span: MKCoordinateSpanMake(0.05, 0.05))
        self.mapView.setRegion(region, animated: true)
        
//        let a1 = MapPin(coordinate: CLLocationCoordinate2D(latitude: 40.4384, longitude: -3.6970))
//        a1.title = "Pin 1"
////        a1.subtitle = "Subtitle 1"
//        a1.shop = Shop(name: "tiendita")
//        self.mapView.addAnnotation(a1)
//
//        let a2 = MapPin(coordinate: CLLocationCoordinate2D(latitude: 40.4839361, longitude: -3.5679515))
//        a2.title = "Pin 2"
////        a2.subtitle = "Subtitle 2"
//        a2.shop = Shop(name: "Aeropuerto")
//        self.mapView.addAnnotation(a2)

        for i in 0..<self.fetchedResultsController.sections![0].numberOfObjects{
            let theShop = self.fetchedResultsController.object(at: IndexPath(row: i, section: 0))
           
            let mapPin = MapPin(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(theShop.latitude), longitude: CLLocationDegrees(theShop.longitude)))
            mapPin.title = theShop.name ?? ""
            mapPin.shop = theShop
            if let dataLogo = theShop.logoData{
                mapPin.logo = UIImage(data: dataLogo)
            }
            
            
            self.mapView.addAnnotation(mapPin)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showShopDetailSegue", let vcShopDetail = segue.destination as? ShopDetailViewController{
//            let indexPath = self.collectionShops.indexPathsForSelectedItems![0]
            let shopCD = sender as! ShopCoreData
            vcShopDetail.shop = shopCoreDataToShop(shopCD: shopCD)
//            vcShopDetail.shop = sender as? Shop
            //la var sender = shop, se lo envía en performSegue desde didSelect
        }
    }
    
    // MARK: - Fetched results controller
    
    var fetchedResultsController: NSFetchedResultsController<ShopCoreData> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<ShopCoreData> = ShopCoreData.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        _fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context!, sectionNameKeyPath: nil, cacheName: "Master")
//        aFetchedResultsController.delegate = self
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    var _fetchedResultsController: NSFetchedResultsController<ShopCoreData>? = nil
    
    //MARK: - CLLocation
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        self.mapView.setCenter(locations[0].coordinate, animated: true)
    }
    
    //MARK: - Map
    @objc func printTapped(){
        print("pin selected")
        
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Don't want to show a custom image if the annotation is the user's location.
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        // Better to make this class property
        let annotationIdentifier = "AnnotationIdentifier"
        
        var annotationView: MKAnnotationView?
        let detailButton = UIButton(type: .detailDisclosure)
        detailButton.addTarget(self, action: #selector(ViewController.printTapped), for: .touchUpInside)
        
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
//            annotationView?.rightCalloutAccessoryView = detailButton
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            let a = annotation as! MapPin
            let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            imgView.image = a.logo ?? #imageLiteral(resourceName: "madrid")
            imgView.contentMode = .scaleAspectFit
            imgView.clipsToBounds = true
            annotationView?.leftCalloutAccessoryView = imgView
        }
        
        if let annotationView = annotationView {
            // Configure your annotation view here
            
            annotationView.canShowCallout = true
            annotationView.image = #imageLiteral(resourceName: "map-marker-icon")//UIImage(named: "marker")
            annotationView.contentMode = .scaleAspectFit
//            annotationView.tintColor = UIColor.red
            
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl){
        print("alloutAccessoryControlTapped")
        let annotation = view.annotation as! MapPin
        performSegue(withIdentifier: "showShopDetailSegue", sender: annotation.shop)
    }
}

