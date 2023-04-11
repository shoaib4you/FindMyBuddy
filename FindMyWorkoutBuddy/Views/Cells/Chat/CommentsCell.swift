//
//  CommentsCell.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 25/12/22.
//

import UIKit

class CommentsCell: UITableViewCell {
    
    @IBOutlet weak var chatLeft: GradientView!
    @IBOutlet weak var lblMsgLeft: UILabel!
    @IBOutlet weak var imgLeft: UIImageView!
    @IBOutlet weak var chatRight: GradientView!
    @IBOutlet weak var lblMsgRight: UILabel!
    @IBOutlet weak var imgRight: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
