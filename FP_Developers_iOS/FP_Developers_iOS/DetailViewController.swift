//
//  DetailViewController.swift
//  FP_Developers_iOS
//
//  Created by parth on 2022-05-27.
//

import UIKit
import AVKit

class DetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    let test_places_images = ["place1_img1", "place1_img2", "place1_img3"]
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //collection view delegate methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return test_places_images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailImageCell", for: indexPath) as! DetailImageCell
        cell.detail_image.image = UIImage(named: test_places_images[indexPath.row])
        return cell
    }

    @IBAction func videoPlayBtn(_ sender: UIButton) {
        guard let videoPath = Bundle.main.path(forResource: "test_video", ofType:"mp4") else {
                    debugPrint("video not found")
                    return
                }
        let player = AVPlayer(url: URL(fileURLWithPath: videoPath))
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    @IBAction func wishlistBtnTap(_ sender: UIButton) {
        //---TEMPORARY REDIRECTION TO ARCHIVE LIST---
        let vc = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "WishlistViewController") as! WishlistViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
