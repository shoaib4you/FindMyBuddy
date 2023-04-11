//
//  Switcher.swift
//  WeCare
//
//  Created by mac on 01/10/18.
//  Copyright © 2018 Technorizen. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class Switcher {
    
    static func updateRootVC() {
        
        let status = k.userDefault.bool(forKey: k.session.status)
        
        if status {
//            let mainViewController = R.storyboard.main().instantiateViewController(withIdentifier: "HomeeVC") as! HomeeVC
//            let leftViewController = R.storyboard.main().instantiateViewController(withIdentifier: "LeftSideMenuVC") as! LeftSideMenuVC
//            let rootVC = SlideMenuController(mainViewController: mainViewController, leftMenuViewController: leftViewController)
//            kAppDelegate.window?.rootViewController = mainViewController
//            kAppDelegate.window?.makeKeyAndVisible()
            
            let mainViewController = R.storyboard.main().instantiateViewController(withIdentifier: "HomeMainVC") as! HomeMainVC
            let leftViewController = R.storyboard.main().instantiateViewController(withIdentifier: "LeftSideMenuVC") as! LeftSideMenuVC
            let rootVC = SlideMenuController(mainViewController: mainViewController, leftMenuViewController: leftViewController)
            kAppDelegate.window?.rootViewController = rootVC
            kAppDelegate.window?.makeKeyAndVisible()
        } else {
            let rootVC = R.storyboard.main().instantiateViewController(withIdentifier: "SplashVC") as! SplashVC
            let nav = UINavigationController(rootViewController: rootVC)
            nav.isNavigationBarHidden = false
            kAppDelegate.window!.rootViewController = nav
            kAppDelegate.window?.makeKeyAndVisible()
        }
    }
}
