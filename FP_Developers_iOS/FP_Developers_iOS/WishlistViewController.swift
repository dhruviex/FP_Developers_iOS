
import UIKit

class WishlistViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let test_places_names = ["Taj Mahal", "Eiffel Tower", "Canals of Amsterdam","Taj Mahal", "Eiffel Tower", "Canals of Amsterdam"]
    let test_places_images = ["place1", "place2", "place3","place1", "place2", "place3"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //collection view delegate methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return test_places_names.count
    }
    
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let component1 = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceViewCell", for: indexPath) as! PlaceViewCell
          component1.place_title.text = test_places_names[indexPath.row]
          component1.place_image.image = UIImage(named: test_places_images[indexPath.row])
          return component1
      }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let DetailViewController = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        self.navigationController?.pushViewController(DetailViewController, animated: true)
    }

}
