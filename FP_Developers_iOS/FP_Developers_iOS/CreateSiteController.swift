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
    var currentImageIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //set image picker delegate
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if (currentImageIndex == 0) {
                img1.contentMode = .scaleToFill
                img1.image = pickedImage
                btn1.isHidden = true
                currentImageIndex = 1
            } else if (currentImageIndex == 1) {
                img2.contentMode = .scaleToFill
                img2.image = pickedImage
                btn2.isHidden = true
                currentImageIndex = 2
            } else if (currentImageIndex == 2) {
                img3.contentMode = .scaleToFill
                img3.image = pickedImage
                btn3.isHidden = true
            }
            
        }

        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func firstBtnTap(_ sender: UIButton) {
        //call image picker preset method
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func secondBtnTap(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func thirdBtnTap(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            present(imagePicker, animated: true, completion: nil)
        }
    }
}
