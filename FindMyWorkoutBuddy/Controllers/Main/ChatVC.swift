//
//  ChatVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 07/09/22.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var tableViewOt: UITableView!
    @IBOutlet weak var lblNotificationCount: UILabel!
    
    var identifier = "ChatListCell"
    var arr:[ResGetConversion] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOt.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.getProfile()
        self.getConversion()
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
    
    func getConversion() {
        Api.shared.getConversion(self, self.paramGetConversion()) { responseData in
            if responseData.count > 0 {
                self.arr = responseData
            } else {
                self.arr = []
            }
            self.tableViewOt.reloadData()
        }
    }
    
    func paramGetConversion() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["receiver_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        return dict
    }
    
    @IBAction func btnMenu(_ sender: UIButton) {
        toggleLeft()
    }
    
    @IBAction func btnNotification(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ChatVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatListCell, for: indexPath)!
        let object = self.arr[indexPath.row]
        if let image = object.image, image != Router.BASE_IMAGE_URL {
            Utility.downloadImageBySDWebImage(object.image ?? "") { (image, error) in
                if error == nil {
                    cell.img.image = image
                }
            }
        }
        cell.lblUserName.text = "\(object.first_name ?? "") \(object.last_name ?? "")"
        cell.lblDistance.text = object.last_message ?? ""
        cell.lblDateTime.text = object.date ?? ""
        return cell
    }
}

extension ChatVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "UserChatVC") as! UserChatVC
        vc.receiverId = self.arr[indexPath.row].receiver_id ?? ""
        vc.senderId = self.arr[indexPath.row].sender_id ?? ""
        vc.userName = "\(self.arr[indexPath.row].first_name ?? "") \(self.arr[indexPath.row].last_name ?? "")"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
