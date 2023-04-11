//
//  ImageCell.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 27/09/22.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var cloTapOnImage:(()-> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImageView(_:)))
        
        // Add Tap Gesture Recognizer
        self.img.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func didTapImageView(_ sender: UITapGestureRecognizer) {
        self.cloTapOnImage?()
    }
}
