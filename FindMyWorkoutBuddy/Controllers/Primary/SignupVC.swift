//
//  SignVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 01/09/22.
//

import UIKit
import CountryPickerView
import AuthenticationServices
import GoogleSignIn

class SignupVC: UIViewController {
    
    @IBOutlet var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var btnTerms: UIButton!
    @IBOutlet weak var txtTaxNumber: UITextField!
    @IBOutlet weak var btnTermsAndcond: UIButton!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var tableViewOt: UITableView!
    
    let cpvInternal = CountryPickerView()
    weak var cpvTextField: CountryPickerView!
    var phoneKey:String?
    var phoneNumber: String = ""
    var isCheck = false
    
    var cloLogin:(()->Void)?
    var comingFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        self.configureCountryView()
    }
    
    func configureCountryView() {
        let cp = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 80, height: 16))
        txtPhone.leftView = cp
        txtPhone.leftViewMode = .always
        self.cpvTextField = cp
        cp.delegate = self
        [cp].forEach {
            $0?.dataSource = self
        }
        cp.countryDetailsLabel.font = UIFont(name: "JosefinSans-Regular", size: 14.0)
        cp.countryDetailsLabel.textColor = .gray
        self.phoneKey = cp.selectedCountry.phoneCode
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.btnTermsAndcond.setTitle(R.string.localizable.forContinueYouNeedToAcceptTermsAndConditions(), for: .normal)
        if L102Language.currentAppleLanguage() == "en" {
            
        } else {
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func btnRegister(_ sender: UIButton) {
        self.registerNow()
    }
    
    func paramSignup() -> [String:String] {
        var dict:[String:String] = [:]
        dict["first_name"] = self.txtFirstName.text!
        dict["last_name"] = self.txtLastName.text!
        dict["email"] = self.txtEmail.text!
        dict["address"] = self.txtLocation.text!
        dict["lat"] = String(kAppDelegate.coordinate2.coordinate.latitude)
        dict["lon"] = String(kAppDelegate.coordinate2.coordinate.longitude)
        dict["mobile"] = self.txtPhone.text!
        dict["password"] = self.txtPassword.text!
        dict["register_id"] = k.emptyString
        dict["ios_register_id"] = k.iosRegisterId
        dict["about_us"] = k.emptyString
        return dict
    }
    
    //    477782284816-ue92ptn0ol83skpg5potup4jnmj2tejd.apps.googleusercontent.com
    func registerNow() {
        print(self.paramSignup())
        Api.shared.signup(self, self.paramSignup(), images: [:], videos: [:]) { (response) in
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "EULAVC") as! EULAVC
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            vc.object = response
            vc.isComingFrom = "register"
            self.present(vc, animated: true, completion: nil)          
        }
    }
    
    func paramSocialLogin(fName: String,lName: String,email: String,mobile: String, socialId: String) -> [String:String] {
        var dict:[String:String] = [:]
        dict["first_name"] = fName
        dict["last_name"] = lName
        dict["email"] = email
        dict["mobile"] = mobile
        dict["social_id"] = socialId
        dict["register_id"] = k.emptyString
        dict["ios_register_id"] = k.iosRegisterId
        return dict
    }
    
    func socialLogin(fName: String,lName: String,email: String,mobile: String, socialId: String) {
        print(self.paramSocialLogin(fName: fName, lName: lName, email: email, mobile: mobile, socialId: socialId))
        Api.shared.socialLogin(self, self.paramSocialLogin(fName: fName, lName: lName, email: email, mobile: mobile, socialId: socialId), images: [:], videos: [:]) { (response) in
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "EULAVC") as! EULAVC
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            vc.object = response
            self.present(vc, animated: true, completion: nil)         
        }
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        if self.comingFrom == "explore" {
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTerms(_ sender: UIButton) {
        if self.btnTerms.image(for: .normal) == R.image.check_box_fill_18pt() {
            self.btnTerms.setImage(R.image.check_box_nill_18pt(), for: .normal)
            self.isCheck = false
        } else {
            self.btnTerms.setImage(R.image.check_box_fill_18pt(), for: .normal)
            self.isCheck = true
        }
    }
    
    @IBAction func btnTermsCond(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "TermsAndCondVC") as! TermsAndCondVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnPasswordEye(_ sender: UIButton) {
        self.txtPassword.isSecureTextEntry.toggle()
        if self.txtPassword.isSecureTextEntry {
            sender.setImage(UIImage(named: "eye"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "hidden"), for: .normal)
            
        }
    }
    
    @IBAction func btnConformPasswordEye(_ sender: UIButton) {
        self.txtConfirmPassword.isSecureTextEntry.toggle()
        if self.txtConfirmPassword.isSecureTextEntry {
            sender.setImage(UIImage(named: "eye"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "hidden"), for: .normal)
            
        }
    }
    
    @IBAction func btnSignInWithGoogle(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func btnSignInWithApple(_ sender: UIButton) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
}

extension SignupVC: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let emailId = appleIDCredential.email
            
            print("User id is \(userIdentifier) \n Full Name is \(String(describing: fullName)) \n Email id is \(String(describing: emailId))")
            self.socialLogin(fName: "\(String(describing: fullName))", lName: "", email: emailId ?? "", mobile: "", socialId: userIdentifier)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}


extension SignupVC : ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

extension SignupVC: CountryPickerViewDelegate {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.phoneKey = country.phoneCode
    }
}

extension SignupVC: CountryPickerViewDataSource {
    
    func preferredCountries(in countryPickerView: CountryPickerView) -> [Country] {
        var countries = [Country]()
        ["GB"].forEach { code in
            if let country = countryPickerView.getCountryByCode(code) {
                countries.append(country)
            }
        }
        return countries
    }
    
    func sectionTitleForPreferredCountries(in countryPickerView: CountryPickerView) -> String? {
        return "Preferred title"
    }
    
    func showOnlyPreferredSection(in countryPickerView: CountryPickerView) -> Bool {
        return false
    }
    
    func navigationTitle(in countryPickerView: CountryPickerView) -> String? {
        return "Select a Country"
    }
}

extension SignupVC: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
            // [START_EXCLUDE silent]
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "ToggleAuthUINotification"), object: nil, userInfo: nil)
            // [END_EXCLUDE]
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
          
            print(userId ?? "")
            print(fullName)
            self.socialLogin(fName: fullName ?? "", lName: "", email: email ?? "", mobile: "", socialId: userId ?? "")
        }
    }
}
