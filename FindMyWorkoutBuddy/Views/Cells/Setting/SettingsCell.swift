//
//  SettingsCell.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 07/09/22.
//

import UIKit

class SettingsCell: UITableViewCell {

    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var findMe: UISwitch!
    @IBOutlet weak var lblProfile: UILabel!
    
    var cloFindMe:((_ findMe: Bool)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        findMe.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnFindMe(_ sender: UISwitch) {
        self.cloFindMe?(sender.isOn)
    }
}
