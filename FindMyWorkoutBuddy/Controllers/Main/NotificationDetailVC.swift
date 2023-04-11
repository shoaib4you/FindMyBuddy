//
//  NotificationDetailVC.swift
//  FxAvenue
//
//  Created by mac on 31/05/21.
//

import UIKit

class NotificationDetailVC: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtMessage: UITextView!
    
    var res:ResNotification?
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
//        setNavigationBarItem(LeftTitle: "", LeftImage: "back", CenterTitle: R.string.localizable.notificationDetail(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
//        if let obj = self.res {
//            if L102Language.currentAppleLanguage() == "en" {
//                self.lblTitle.text = obj.title ?? ""
//                self.txtMessage.text = obj.message ?? ""
//            } else {
//                self.lblTitle.text = obj.titleGr ?? ""
//                self.txtMessage.text = obj.messageGr ?? ""
//            }
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
