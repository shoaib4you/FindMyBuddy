//
//  JournalActivityCell.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 23/03/23.
//

import UIKit

class JournalActivityCell: UITableViewCell {

    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    
    
    var cloDelete:(()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnDelete(_ sender: UIButton) {
        self.cloDelete?()
    }
}
