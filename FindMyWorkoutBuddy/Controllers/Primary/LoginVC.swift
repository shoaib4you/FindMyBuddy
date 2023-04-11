//
//  LoginVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 01/09/22.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet var txtPhone: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    
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
    
    @IBAction func btnLogin(_ sender: UIButton) {
        if self.txtPassword.hasText && self.txtPhone.hasText {
            login()
        } else {
            self.alert(alertmessage: R.string.localizable.pleaseEnterValidDetails())
        }
    }
    
    func paramLogin() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["email"]               =   self.txtPhone.text! as AnyObject
        dict["password"]            =   self.txtPassword.text! as AnyObject
        dict["register_id"]         =   k.emptyString as AnyObject
        dict["ios_register_id"]     =   k.iosRegisterId as AnyObject
        return dict
    }
    
    func login() {
        print(self.paramLogin())
        Api.shared.login(self, self.paramLogin()) { (response) in
            k.userDefault.set(true, forKey: k.session.status)
            k.userDefault.set(response.id ?? "", forKey: k.session.userId)
            k.userDefault.set("\(response.first_name ?? "") \(response.last_name ?? "")", forKey: k.session.userName)
            k.userDefault.set(response.image ?? "", forKey: k.session.userImage)
            k.userDefault.set(response.email ?? "", forKey: k.session.userEmail)
            k.userDefault.set(response.type ?? "", forKey: k.session.userType)
            Switcher.updateRootVC()
        }
    }
    
    @IBAction func btnSignup(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnForgotPassword(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnEye(_ sender: UIButton) {
        self.txtPassword.isSecureTextEntry.toggle()
        if self.txtPassword.isSecureTextEntry {
            sender.setImage(UIImage(named: "eye"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "hidden"), for: .normal)
            
        }
    }
}
