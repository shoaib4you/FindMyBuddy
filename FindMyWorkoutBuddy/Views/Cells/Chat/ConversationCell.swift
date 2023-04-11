//
//  ConversationCell.swift
//  AskYourCommunity
//
//  Created by mac on 28/05/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class ConversationCell: UITableViewCell {

    @IBOutlet weak var chatLeft: GradientView!
    @IBOutlet weak var lblMsgLeft: UILabel!
    @IBOutlet weak var imgLeft: UIImageView!
    @IBOutlet weak var chatRight: GradientView!
    @IBOutlet weak var lblMsgRight: UILabel!
    @IBOutlet weak var imgRight: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
