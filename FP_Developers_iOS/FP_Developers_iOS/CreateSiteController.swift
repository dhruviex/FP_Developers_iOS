//
//  CreateSiteController.swift
//  FP_Developers_iOS
//
//  Created by parth on 2022-05-30.
//

import UIKit

class CreateSiteController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject: AnyObject]){
            self.dismiss(animated: true, completion: { () -> Void in

            })
        print("IMAGE------>",image as Any)
        self.img1.image = image
        self.btn1.isHidden = true
        }
    
    @IBAction func firstBtnTap(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                    print("Button capture")

                    imagePicker.delegate = self
                    imagePicker.sourceType = .savedPhotosAlbum
                    imagePicker.allowsEditing = false

                    present(imagePicker, animated: true, completion: nil)
                }
    }
    
    @IBAction func secondBtnTap(_ sender: UIButton) {
    }
    
    @IBAction func thirdBtnTap(_ sender: UIButton) {
    }
}
