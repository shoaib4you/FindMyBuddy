//
//  aaViewController.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 01/11/22.
//

import UIKit

class aaViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "UserChatVC") as! UserChatVC
               vc.receiverId = "8"
               vc.senderId = "10"
               vc.userName = "sadfsdf"
               self.navigationController?.pushViewController(vc, animated: true)
    }
}
