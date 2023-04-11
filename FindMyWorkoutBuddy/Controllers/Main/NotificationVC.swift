//
//  NotificationVC.swift
//  FxAvenue
//
//  Created by mac on 05/05/21.
//

import UIKit

class NotificationVC: UIViewController {
    
    @IBOutlet weak var tbl: UITableView!
    
    var identifier = "NotificationCell"
    var arr:[ResNotification] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbl.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
        setNavigationBarItem(LeftTitle: "", LeftImage: "back", CenterTitle: R.string.localizable.notification(), CenterImage: "", RightTitle: "", RightImage: "remove", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        self.getNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func getNotification() {
        Api.shared.getNotification(self) { (response) in
            if response.count > 0 {
                self.arr = response
            } else {
                self.arr = []
            }
            self.tbl.reloadData()
        }
    }
    
    override func rightClick() {
        self.deleteAllNotification()
    }
    
    func deleteAllNotification() {
        Api.shared.deleteAllNotification(self, self.paramDeleteAllNotification()) { responseData in
            self.getNotification()
        }
    }
        
    func paramDeleteAllNotification() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        return dict
    }
    
    func deleteNotification(_ id: String) {
        Api.shared.deleteSingleNotification(self, self.paramDeleteNotification(id)) { responseData in
            self.getNotification()
        }
    }
    
    func paramDeleteNotification(_ id: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["id"] = id as AnyObject
        return dict
    }
}

extension NotificationVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.notificationCell, for: indexPath)!
        let obj = self.arr[indexPath.row]
        //        if L102Language.currentAppleLanguage() == "en" {
//        cell.lblTitle.text = obj.title ?? ""
//        if L102Language.currentAppleLanguage() == "en" {
//
//        } else {
//            cell.lblDesc.text = obj.messageGr ?? ""
//        }
        cell.lblDesc.text = obj.message ?? ""
        cell.lblDate.text = obj.date_time ?? ""
//        if let img = obj.userDetails?.image, img != Router.BASE_IMAGE_URL {
//            Utility.setImageWithSDWebImage(obj.userDetails?.image ?? "", cell.img)
//        }
//        cell.lblTitle.text = obj.title ?? ""
        //        } else {
        //            cell.lblTitle.text = obj.titleFr ?? ""
        //            cell.lblMessage.text = obj.messageFr ?? ""
        //        }
//        cell.lblDateTime.text = obj.dateTime ?? ""
//        cell.cloDelete = {() in
//            self.deleteNotification(obj.id ?? "")
//        }
        
        cell.cloRemove = {() in
            self.deleteNotification(obj.id ?? "")
        }
        return cell
    }
}

extension NotificationVC: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let status = self.arr[indexPath.row].status, status == "ADD_OFFER" {
//            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ConReceivedOffersVC") as! ConReceivedOffersVC
//            vc.contractId = self.arr[indexPath.row].contractId ?? ""
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//        if let status = self.arr[indexPath.row].status, status == "CHANGE_STATUS" {
//            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "EmpOrderMainVC") as! EmpOrderMainVC
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//    }
}
