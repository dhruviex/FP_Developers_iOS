//
//  MainScreenController.swift
//  FP_Developers_iOS
//
//  Created by parth on 2022-05-26.
//

import UIKit
import MapKit

class MainScreenController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource ,CLLocationManagerDelegate ,UITextFieldDelegate{
   

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var textField_Address: UITextField!
    //Location On Map
    let locationManager = CLLocationManager()
    var myGeoCoder = CLGeocoder()
    
    let test_places = ["Taj Mahal", "Eiffel Tower", "Canals of Amsterdam"]
    let test_places_images = ["place1", "place2", "place3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mapView.showsUserLocation = false
        mapView.isZoomEnabled = true
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        locationManager.startUpdatingLocation()
        // Coordinates on Map
        let coordinates = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0, longitude:    locationManager.location?.coordinate.longitude ?? 0.0)

        let span = MKCoordinateSpan (latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: coordinates, span: span)
        mapView.setRegion(region, animated: true)
        
        // Annotation On Map
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
    //Action By the Search Button
    @IBAction func searchBtn(_ sender: UIButton) {
        myGeoCoder.geocodeAddressString(textField_Address.text ?? ""){
            (placemarks,error) in
            self.processResponse(withPlacemarks: placemarks, error: error)
    }
}
    
    //Function for the Placemark on the Map
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
                // For the Annotation
                let myPin = MKPointAnnotation()
                
                myPin.coordinate = coordinate
                
                myPin.title = textField_Address.text
                mapView.addAnnotation(myPin)
                
        }
        
    }
    }
    
}
