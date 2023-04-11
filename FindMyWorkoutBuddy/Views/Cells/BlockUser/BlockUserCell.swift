//
//  BlockUserCell.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 01/11/22.
//

import UIKit

class BlockUserCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    
    var cloUnBlock:(()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnUnBlock(_ sender: UIButton) {
        self.cloUnBlock?()
    }
}
