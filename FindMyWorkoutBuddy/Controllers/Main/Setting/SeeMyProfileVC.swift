//
//  SeeMyProfileVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 24/10/22.
//

import UIKit

class SeeMyProfileVC: UIViewController {

    @IBOutlet weak var btnEveryone: UIButton!
    @IBOutlet weak var btnFriends: UIButton!
    
    var param = ""
    var cloRefresh:(()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        Api.shared.canSeeProfile(self, self.paramCanSeeProfile()) { responseData in
            self.dismiss(animated: true) {
                self.cloRefresh?()
            }
        }
    }
    
    func paramCanSeeProfile() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["can_see_profile"] = self.param as AnyObject
        return dict
    }
    
    @IBAction func btnEveryone(_ sender: UIButton) {
        self.param = "Everyone"
        self.btnEveryone.setImage(R.image.radio_checked(), for: .normal)
        self.btnFriends.setImage(R.image.radio_unchecked(), for: .normal)
    }
    
    @IBAction func btnFriends(_ sender: UIButton) {
        self.param = "Friends"
        self.btnEveryone.setImage(R.image.radio_unchecked(), for: .normal)
        self.btnFriends.setImage(R.image.radio_checked(), for: .normal)
    }
}
