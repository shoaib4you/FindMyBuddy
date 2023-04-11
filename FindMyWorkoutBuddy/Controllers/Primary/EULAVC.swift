//
//  EULAVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 15/03/23.
//

import UIKit
import WebKit

class EULAVC: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    @IBOutlet var btnTerms: UIButton!
    
    var isCheck = false
    var object: ResLoginProfile?
    var isComingFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: k.languages.english.urlEULA)!
        webview.navigationDelegate = self
        webview.load(URLRequest(url: url))
        webview.allowsBackForwardNavigationGestures = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "back", CenterTitle: R.string.localizable.termsAndConditions(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
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
    
   
    @IBAction func btnIAgree(_ sender: UIButton) {
        if isCheck {
            if isComingFrom == "register" {
                Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.yourAccountIsCreatedSuccessfullyWeHaveSentOneConfirmationMailToYourMailIdSoPleaseConfirmAndLoginInApp(), delegate: nil, parentViewController: self) { (boool) in
                    k.userDefault.set(false, forKey: k.session.status)
                    Switcher.updateRootVC()
                }
            } else {
                if let response = object {
                    k.userDefault.set(true, forKey: k.session.status)
                    k.userDefault.set(response.id ?? "", forKey: k.session.userId)
                    k.userDefault.set("\(response.first_name ?? "") \(response.last_name ?? "")", forKey: k.session.userName)
                    k.userDefault.set(response.image ?? "", forKey: k.session.userImage)
                    k.userDefault.set(response.email ?? "", forKey: k.session.userEmail)
                    k.userDefault.set(response.type ?? "", forKey: k.session.userType)
                    Switcher.updateRootVC()
                }
            }
        } else {
            Utility.showAlertMessage(withTitle: k.appName, message: R.string.localizable.youMustAgreeToOurTermAndCondition(), delegate: nil, parentViewController: self)
        }
    }
}

extension EULAVC: WKNavigationDelegate {
    
    
}
