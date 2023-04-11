//
//  FeedImageCell.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 15/01/23.
//

import UIKit

class FeedImageCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var btnReport: UIButton!
    
    var cloReport:(()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func btnReport(_ sender: UIButton) {
        self.cloReport?()
    }
}
