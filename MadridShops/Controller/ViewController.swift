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
        
        if defaults.value(forKey: "saved") != nil{
            self.collectionShops.delegate = self
            self.collectionShops.dataSource = self
        }

       //map
        self.locationManager.requestWhenInUseAuthorization()
        
        let madridLocation = CLLocation(latitude: 40.4384, longitude: -3.6970)

        
        let region = MKCoordinateRegion(center: madridLocation.coordinate, span: MKCoordinateSpanMake(0.05, 0.05))
        self.mapView.setRegion(region, animated: true)
    

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

            let shopCD = sender as! ShopCoreData
            vcShopDetail.shop = shopCoreDataToShop(shopCD: shopCD)

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
            annotationView.image = #imageLiteral(resourceName: "map-marker-icon")
            annotationView.contentMode = .scaleAspectFit

            
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl){
        print("alloutAccessoryControlTapped")
        let annotation = view.annotation as! MapPin
        performSegue(withIdentifier: "showShopDetailSegue", sender: annotation.shop)
    }
}

