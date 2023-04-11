//
//  NewRequestCell.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 07/09/22.
//

import UIKit

class NewRequestCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    
    var cloIgnore:(()->Void)?
    var cloAccept:(()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnIgnore(_ sender: UIButton) {
        self.cloIgnore?()
    }
    
    @IBAction func btnAccept(_ sender: UIButton) {
        self.cloAccept?()
    }
}
