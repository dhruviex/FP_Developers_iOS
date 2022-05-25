//
//  ViewController.swift
//  FP_Developers_IOS_
//
//  Created by Dhruv Bakshi on 2022-05-25.
//

import UIKit
import MapKit

class ViewController: UIViewController ,CLLocationManagerDelegate ,UITextFieldDelegate{

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var textField_Address: UITextField!
    
    let locationManager = CLLocationManager()
    var myGeoCoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
}

