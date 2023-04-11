//
//  SettingVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 01/09/22.
//

import UIKit

class SettingVC: UIViewController {

    @IBOutlet weak var tableViewOt: UITableView!
    
    var identifier = "SettingsCell"
    var arr = [
        R.string.localizable.changeLanguage(),
        R.string.localizable.changePassword(),
        R.string.localizable.blockedUsers(),
//        R.string.localizable.reportUsers(),
//        R.string.localizable.findMe(),
        R.string.localizable.whoCanSeeYourProfile(),
        R.string.localizable.giveFeedback(),
        R.string.localizable.termsAndConditions(),
        R.string.localizable.privacyPolicy(),
        R.string.localizable.contactUs(),
        R.string.localizable.deleteAccount()
    ]
    var findMe: Bool = false
    var canSeeProfile = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOt.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.getProfile()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func leftClick() {
        toggleLeft()
    }
    
    func getProfile() {
        Api.shared.getProfile(self) { responseData in
            if let findMee = responseData.can_see_profile, findMee == "Everyone" {
                self.canSeeProfile = "Everyone"
            } else {
                self.canSeeProfile = "Friends"
            }
            self.tableViewOt.reloadData()
        }
    }
    
    func updateFindMeStatus(_ status: String) {
        Api.shared.updateFindMeStatus(self, self.paramUpdateFindMeStatus(status)) { responseData in
            
        }
    }
    
    func paramUpdateFindMeStatus(_ status: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["find_me"] = status as AnyObject
        return dict
    }
    
    @IBAction func btnMenu(_ sender: UIButton) {
        toggleLeft()
    }
}

extension SettingVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.settingsCell, for: indexPath)!
        cell.lbl.text = self.arr[indexPath.row]
        cell.lblProfile.isHidden = true
        cell.findMe.isHidden = true
//        if indexPath.row == 4 {
//            cell.findMe.isHidden = false
//            cell.img.isHidden = true
//            if findMe {
//                cell.findMe.isOn = true
//            } else {
//                cell.findMe.isOn = false
//            }
//        } else {
//            cell.img.isHidden = false
//        }
        
        if indexPath.row == 3 {
            cell.lblProfile.isHidden = false
            cell.lblProfile.text = self.canSeeProfile
        }
        
        cell.cloFindMe = {(isOn) in
            if isOn {
                self.updateFindMeStatus("Yes")
            } else {
                self.updateFindMeStatus("No")
            }
        }
        return cell
    }
    
    func deleteAccount() {
        Api.shared.deleteAccount(self) { responseData in
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            Switcher.updateRootVC()
        }
    }
}

extension SettingVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ChangeLanguageVC") as! ChangeLanguageVC
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "BlockedUserVC") as! BlockedUserVC
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "SeeMyProfileVC") as! SeeMyProfileVC
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            vc.cloRefresh = {() in
                self.getProfile()
            }
            self.present(vc, animated: true, completion: nil)
        case 4:
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "SendFeedBackVC") as! SendFeedBackVC
            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "TermsAndCondVC") as! TermsAndCondVC
            self.navigationController?.pushViewController(vc, animated: true)
        case 6:
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "PrivacyPolicyVC") as! PrivacyPolicyVC
            self.navigationController?.pushViewController(vc, animated: true)
        case 7:
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
            self.navigationController?.pushViewController(vc, animated: true)
        case 8:
            Utility.showAlertYesNoAction(withTitle: k.appName, message: R.string.localizable.areYouSureYouWantToDeleteYourAccount() , delegate: nil, parentViewController: self) { bool in
                if bool {
                    self.deleteAccount()
                }
            }
        default:
            print("")
        }
    }
}
