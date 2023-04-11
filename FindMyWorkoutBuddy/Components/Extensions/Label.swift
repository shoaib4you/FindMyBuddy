//
//  Label.swift
//  ServiceProvider
//
//  Created by mac on 09/12/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ShadowLabel: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.init(red: 241/256, green: 241/256, blue: 241/256, alpha: 1).cgColor
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 1.0
        
        self.layer.masksToBounds = false
        // set backgroundColor in order to cover the shadow inside the bounds
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.sublayerTransform = CATransform3DMakeTranslation(0, 0, 0)
    }
}

class ShadowLabelMore: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderColor = UIColor.init(red: 241/256, green: 241/256, blue: 241/256, alpha: 1).cgColor
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 1.0
        
        self.layer.masksToBounds = false
        // set backgroundColor in order to cover the shadow inside the bounds
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.sublayerTransform = CATransform3DMakeTranslation(0, 0, 0)
    }
}
