//
//  ForfotPasswordVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 01/09/22.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var txtPhone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }

    @IBAction func btnSubmit(_ sender: UIButton) {
        self.forgotPassword()
    }
    
    func paramForgotPassword() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["email"] = self.txtPhone.text! as AnyObject
        return dict
    }
    
    func forgotPassword() {
        Api.shared.forgotPassword(self, self.paramForgotPassword()) { (response) in
            if response.status == "1" {
                Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.weSentYourCurrentPasswordToYourMailPleaseCheckAndLoginAgain(), delegate: nil, parentViewController: self) { (bool) in
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                Utility.showAlertMessage(withTitle: k.appName, message: response.result ?? "", delegate: nil, parentViewController: self)
            }
        }
    }
    
    @IBAction func btnClose(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
