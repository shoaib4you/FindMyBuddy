//
//  NotificationCell.swift
//  Speedo
//
//  Created by mac on 05/03/22.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    var cloRemove:(()->Void)?
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnRemove(_ sender: UIButton) {
        self.cloRemove?()
    }
}
