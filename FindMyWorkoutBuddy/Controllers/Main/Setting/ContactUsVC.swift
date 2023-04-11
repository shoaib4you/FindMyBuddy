//
//  ContactUsVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 24/10/22.
//

import UIKit

class ContactUsVC: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtContactNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem(LeftTitle: "", LeftImage: "back", CenterTitle: R.string.localizable.contactUs(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func btnSend(_ sender: UIButton) {
        Api.shared.sendFeedback(self, self.paramSendFeedBack()) { responseData in
            Utility.showAlertMessage(withTitle: k.appName, message: R.string.localizable.feedbackSentSuccessfully(), delegate: nil, parentViewController: self)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func paramSendFeedBack() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["name"] = self.txtName.text as AnyObject
        dict["contact_number"] = self.txtContactNumber.text as AnyObject
        dict["email"] = self.txtEmail.text as AnyObject
        dict["feedback"] = self.txtMessage.text as AnyObject
        return dict
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
