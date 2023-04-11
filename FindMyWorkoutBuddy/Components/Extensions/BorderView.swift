//
//  BorderView.swift
//  WeCare
//
//  Created by mac on 09/10/18.
//  Copyright © 2018 Technorizen. All rights reserved.
//

import UIKit

class BorderView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderColor = UIColor.init(red: 241/256, green: 241/256, blue: 241/256, alpha: 1).cgColor

        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: -2)
        self.layer.shadowRadius = 7
        self.layer.shadowOpacity = 0.7
        
        self.layer.masksToBounds = false
        self.layer.backgroundColor = UIColor.white.cgColor
    }
}

class BorderViewClear: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 1.5
        //        self.layer.borderColor = UIColor.init(colorLiteralRed: 241/256, green: 241/256, blue: 241/256, alpha: 1).cgColor
        
        self.layer.borderColor = UIColor.init(red: 241/256, green: 241/256, blue: 241/256, alpha: 1).cgColor
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 2.0
        
        self.layer.masksToBounds = false
        // set backgroundColor in order to cover the shadow inside the bounds
        self.layer.backgroundColor = UIColor.init(named: "background")?.cgColor
        
        //        self.layer.sublayerTransform = CATransform3DMakeTranslation(0, 0, 0)
    }
}

class BorderViewWithShadow: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.init(red: 241/256, green: 241/256, blue: 241/256, alpha: 1).cgColor
        
        self.layer.shadowColor =  UIColor.init(red: 215/256, green: 215/256, blue: 215/256, alpha: 1).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 4.0
        
        self.layer.masksToBounds = false
        // set backgroundColor in order to cover the shadow inside the bounds
        self.layer.backgroundColor = UIColor.white.cgColor
    }
}

extension UIView {

    enum ViewSide {
        case Left, Right, Top, Bottom
    }

    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {

        let border = CALayer()
        border.backgroundColor = color

        switch side {
        case .Left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
        case .Right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
        case .Top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
        case .Bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); break
        }

        layer.addSublayer(border)
    }
}

class BorderViewTopSimple: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.init(red: 241/256, green: 241/256, blue: 241/256, alpha: 1).cgColor
        
        self.layer.shadowColor =  UIColor.init(red: 215/256, green: 215/256, blue: 215/256, alpha: 1).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: -4.0)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 4.0
        
       // self.layer.masksToBounds = false
        // set backgroundColor in order to cover the shadow inside the bounds
       // self.layer.backgroundColor = UIColor.white.cgColor
    }
}
