//
//  FindBuddyMainVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 06/09/22.
//

import UIKit

class FindBuddyMainVC: UIViewController {

    @IBOutlet weak var vwList: UIView!
    @IBOutlet weak var btnList: UIButton!
    @IBOutlet weak var lblList: UILabel!
    @IBOutlet weak var vwMap: UIView!
    @IBOutlet weak var btnMap: UIButton!
    @IBOutlet weak var lblMap: UILabel!
    @IBOutlet weak var lblNotificationCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.vwMap.isHidden = true
        self.vwList.isHidden = false
        self.btnList.setTitleColor(R.color.theme_color(), for: .normal)
        self.btnMap.setTitleColor(.gray, for: .normal)
        self.lblMap.textColor = .white
        self.lblList.textColor = R.color.theme_color()
        self.getProfile()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func getProfile() {
        Api.shared.getProfile(self) { responseData in
            if let notiCount = responseData.noti_count, notiCount != "0" {
                self.lblNotificationCount.isHidden = false
                self.lblNotificationCount.text = "\(notiCount)"
            } else {
                self.lblNotificationCount.isHidden = true
            }
        }
    }
    
    @IBAction func btnList(_ sender: UIButton) {
        self.vwMap.isHidden = true
        self.vwList.isHidden = false
        self.btnList.setTitleColor(R.color.theme_color(), for: .normal)
        self.btnMap.setTitleColor(.gray, for: .normal)
        self.lblMap.backgroundColor = .white
        self.lblList.backgroundColor = R.color.theme_color()
    }
    
    @IBAction func btnMap(_ sender: UIButton) {
        self.vwMap.isHidden = false
        self.vwList.isHidden = true
        self.btnList.setTitleColor(.gray, for: .normal)
        self.btnMap.setTitleColor(R.color.theme_color(), for: .normal)
        self.lblMap.backgroundColor = R.color.theme_color()
        self.lblList.backgroundColor = .white
    }
    
    @IBAction func btnMenu(_ sender: UIButton) {
        toggleLeft()
    }
    
    @IBAction func btnNotification(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnFindLocation(_ sender: UISwitch) {
        if sender.isOn {
            self.updateFindMeStatus("Yes")
        } else {
            self.updateFindMeStatus("No")
        }
    }
    
    func updateFindMeStatus(_ status: String) {
        Api.shared.updateFindMeStatus(self, self.paramUpdateFindMeStatus(status)) { responseData in
            if status == "No" {
                Utility.showAlertMessage(withTitle: k.appName, message: R.string.localizable.yourLocationIsHiddenToOtherUsers(), delegate: nil, parentViewController: self)
            }
        }
    }
    
    func paramUpdateFindMeStatus(_ status: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["find_me"] = status as AnyObject
        return dict
    }
}
