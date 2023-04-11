//
//  ImageVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 05/03/23.
//

import UIKit

class ImageVC: UIViewController {

    @IBOutlet weak var img: UIImageView!
    
    var image: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imgg = image {
            Utility.downloadImageBySDWebImage(imgg) { image, error in
                self.img.image = image
            }
        }
    }
    
    @IBAction func btnClose(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
