//
//  MainScreenController.swift
//  FP_Developers_iOS
//
//  Created by parth on 2022-05-26.
//

import UIKit
import MapKit

class MainScreenController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource,CLLocationManagerDelegate ,UITextFieldDelegate {
  
    var arradata = ["WishList", "Create Site", "Contact us", "About"]
    
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var sideBar: UITableView!
    
    var isSideViewOpen: Bool = false
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var textField_Address: UITextField!
    let test_places = ["Egypt", "Banff National Park", "Eiffel Tower"]
    let test_places_images = ["place1_img1", "place2_img1", "place3_img1"]
    
    let locationManager = CLLocationManager()
    var myGeoCoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //
        sideView.isHidden = true
        isSideViewOpen = false
        
        // Do any additional setup after loading the view.
        mapView.showsUserLocation = false
        mapView.isZoomEnabled = true
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        locationManager.startUpdatingLocation()
        
        let coordinates = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0, longitude: locationManager.location?.coordinate.longitude ?? 0.0)

        let span = MKCoordinateSpan (latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: coordinates, span: span)
        mapView.setRegion(region, animated: true)
        
        let myPin = MKPointAnnotation()
        
        myPin.coordinate = coordinates
        myPin.title = "Hi I'm Here"
        myPin.subtitle = "Where Would you like to Go?"
        mapView.addAnnotation(myPin)
        
        textField_Address.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    

    @IBAction func searchBtn(_ sender: UIButton) {
        myGeoCoder.geocodeAddressString(textField_Address.text ?? ""){
            (placemarks,error) in
            self.processResponse(withPlacemarks: placemarks, error: error)
               }
    }
    func processResponse(withPlacemarks placemarks:[CLPlacemark]?,error: Error?){
        if let error = error{
            print("error Fetching Coordinates (\(error)")
        }else {
            var location :CLLocation?
            
            if let placemarks = placemarks, placemarks.count > 0{
                location = placemarks.first?.location
            }
            
            if let location = location{
                
                let coordinate = location.coordinate
                
                
                let request = MKDirections.Request()
                request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0, longitude: locationManager.location?.coordinate.longitude ?? 0.0)))
                request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)))
                request.transportType = .any
                request.requestsAlternateRoutes = true
                                           
                let directions = MKDirections(request: request)
                directions.calculate{response , error in
                guard let directionsresponse = response else {return}
            
                    for route in directionsresponse.routes{
                        self.mapView.addOverlay(route.polyline)
                        self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                    }
                                           
            }
                
                let myPin = MKPointAnnotation()
                
                myPin.coordinate = coordinate
                
                myPin.title = textField_Address.text
                mapView.addAnnotation(myPin)
                
           }
        
        }
    }
    //collection view delegate methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return test_places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceViewCell", for: indexPath) as! PlaceViewCell
        cell.place_title.text = test_places[indexPath.row]
        cell.place_image.image = UIImage(named: test_places_images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let DetailViewController = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        self.navigationController?.pushViewController(DetailViewController, animated: true)
    }
    

    //menu list items
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arradata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.lbl.text = arradata[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //managed drawer navigation with indexpath
        if (indexPath.row == 0) {
            let WishlistViewController = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "WishlistViewController") as! WishlistViewController
            self.navigationController?.pushViewController(WishlistViewController, animated: true)
        } else if (indexPath.row == 1) {
            let CreateSiteController = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "CreateSiteController") as! CreateSiteController
            self.navigationController?.pushViewController(CreateSiteController, animated: true)
        } else if (indexPath.row == 2) {
            let ContactUsController = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "ContactUsController") as! ContactUsController
            self.navigationController?.pushViewController(ContactUsController, animated: true)
        } else if (indexPath.row == 3) {
            let AboutViewController = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
            self.navigationController?.pushViewController(AboutViewController, animated: true)
        }
    }
    
   
    @IBAction func btnMenu(_ sender: UIButton) {
        
        // menu button
        sideBar.isHidden = false
        sideView.isHidden = false
        self.view.bringSubviewToFront(sideView)
        if !isSideViewOpen {
            isSideViewOpen = true
            sideView.frame = CGRect(x: 0, y: 96, width: 0, height: 399)
            sideBar.frame = CGRect(x: 0, y: 0, width: 0, height: 399)
            UIView.setAnimationDuration(0.3)
            UIView.setAnimationDelegate(self)
            UIView.beginAnimations("TableAnimation", context: nil)
            sideView.frame = CGRect(x: 1, y: 96, width: 208, height: 399)
            sideBar.frame = CGRect(x: 0, y: 0, width: 208, height: 399)
            UIView.commitAnimations()
        } else {
            
            // for menu
            sideBar.isHidden = true
            sideView.isHidden = true
            isSideViewOpen = false
            sideView.frame = CGRect(x: 1, y: 96, width: 208, height: 399)
            sideBar.frame = CGRect(x: 0, y: 0, width: 208, height: 399)
            UIView.setAnimationDuration(0.3)
            UIView.setAnimationDelegate(self)
            UIView.beginAnimations("TableAnimation", context: nil)
            sideView.frame = CGRect(x: 0, y: 89, width: 0, height: 517)
            sideBar.frame = CGRect(x: 0, y: 0, width: 0, height: 509)
            UIView.commitAnimations()

    
        }
            
    }
    
}
