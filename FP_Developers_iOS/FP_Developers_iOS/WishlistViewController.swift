//
//  WishlistViewController.swift
//  FP_Developers_iOS
//
//  Created by parth on 2022-05-27.
//

import UIKit

class WishlistViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let test_places = ["The Great Pyramids", "Banff National Park", "Eiffel Tower","Machu Picchu", "Taj Mahal", "Moraine Lake", "Mount Royal", "Petit-Champlain","Haridwar","Hawa Mahal"]
    let test_places_images = ["place1_img1", "place2_img1", "place3_img1", "place4_img1", "place5_img1", "place6_img1", "place7_img1", "place8_img1", "place9_img1", "place10_img1"]
    let test_location = ["Cairo, Egypt", "Banff, AB", "Paris, France", "Cusco Region‎, Peru", "Agra, ‎India", "Montreal,Quebec", "Alberta,Canada", "Quebec,Canada", "Uttrakhand,India", "Jaipur,Rajasthan"]
    let test_ratings = ["4.5","4.2","4.4","4.3","4.6","4.8","4.7","4.5","4.3","4.9"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //collection view delegate methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return test_places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceViewCell", for: indexPath) as! PlaceViewCell
        cell.place_title.text = test_places[indexPath.row]
        cell.place_location.text = test_location[indexPath.row]
        cell.place_rating.text = test_ratings[indexPath.row]
        cell.place_image.image = UIImage(named: test_places_images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let DetailViewController = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        self.navigationController?.pushViewController(DetailViewController, animated: true)
    }
    
    @IBAction func createSiteTapped(_ sender: UIButton) {
        let createSiteController = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "CreateSiteController") as! CreateSiteController
        self.navigationController?.pushViewController(createSiteController, animated: true)
    }
    
}
