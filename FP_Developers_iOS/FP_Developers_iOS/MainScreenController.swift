//
//  MainScreenController.swift
//  FP_Developers_iOS
//
//  Created by parth on 2022-05-26.
//

import UIKit
import MapKit

class MainScreenController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate,UITableViewDataSource {
   
    //
    
    var arradata = ["Wish List", "Site", "Contact us", "About"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arradata.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.lbl.text = arradata[indexPath.row]
        return cell
    }
    
    
    @IBOutlet weak var sideView: UIView!
    
    
    @IBOutlet weak var sideBar: UITableView!
    
    var isSideViewOpen: Bool = false
    
    
    
    
    
    //

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    
    let test_places = ["Taj Mahal", "Eiffel Tower", "Canals of Amsterdam"]
    let test_places_images = ["place1", "place2", "place3"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        
        sideView.isHidden = true
        isSideViewOpen = false
        

        //
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
    
    
    
    @IBAction func btnMenu(_ sender: UIButton) {
        
        sideBar.isHidden = false
        sideView.isHidden = false
       
    
        
        
        
        
        
    }
    
    
    

}
