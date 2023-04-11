//
//  UserChatVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 05/10/22.
//

import UIKit
import SDWebImage

class UserChatVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tvMsg: UITextView!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var vwMsg: GradientView!
    @IBOutlet weak var btnPicture: UIButton!
    
    var arrMsgs:[ResChat] = []
    var requestId = ""
    var receiverId = ""
    var senderId = ""
    var userName = ""
    var refreshControl = UIRefreshControl()
    var image:UIImage?
    var isFromNotification = false
    var rating = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvMsg.textColor = UIColor.white
        tvMsg.text = R.string.localizable.sendMessage()
        //        bottomConst.constant = 0
        if #available(iOS 10.0, *) {
            self.tblView.refreshControl = refreshControl
        } else {
            self.tblView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(self.getChat), for: .valueChanged)
        self.getChat()
        NotificationCenter.default.addObserver(self, selector: #selector(ShowRequest), name: Notification.Name("NewMessage"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UserChatVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UserChatVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setNavigationBarItem(LeftTitle: "", LeftImage: "back", CenterTitle: userName, CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#999999", BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func leftClick() {
        if isFromNotification {
            Switcher.updateRootVC()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func paramGetChat() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["receiver_id"] = senderId as AnyObject
        dict["sender_id"] = receiverId as AnyObject
        dict["request_id"] = self.requestId as AnyObject
        dict["type"] = "NORMAL" as AnyObject
        return dict
    }
    
    @objc func getChat() {
        print(paramGetChat())
        Api.shared.getChat(self, self.paramGetChat()) { (response) in
            if response.count > 0 {
                self.arrMsgs = response
            } else {
                self.arrMsgs = []
            }
            self.tblView.reloadData()
            self.scrollToBottom()
        }
    }
    
    @objc func ShowRequest (notification:NSNotification) {
        if let Dic = notification.object as? NSDictionary {
            print(Dic)
            self.getChat()
        }
    }
    
    @IBAction func btnCamera(_ sender: UIButton) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.image = image
            self.tvMsg.text = ""
            self.sendChat()
        }
    }
    
    @IBAction func actionSend(_ sender: Any) {
        if tvMsg.text == R.string.localizable.writeHere() || tvMsg.text.count == 0 {
            self.alert(alertmessage: R.string.localizable.pleaseEnterMessage())
        } else {
            self.sendChat()
        }
    }
    
    func paramSendChat() -> [String:String] {
        var dict : [String:String] = [:]
        dict["receiver_id"] = senderId
        dict["sender_id"] = receiverId as? String
        dict["request_id"] = self.requestId
        dict["type"] = "NORMAL"
        dict["chat_message"] = self.tvMsg.text!
        dict["timezone"] = localTimeZoneIdentifier
        dict["date_time"] = CURRENT_TIME
        return dict
    }
    
    func imageSendChat() -> [String: UIImage] {
        var dict : [String: UIImage] = [:]
        dict["chat_image"] = self.image
        return dict
    }
    
    func sendChat() {
        print(self.paramSendChat())
        Api.shared.sendChat(self, self.paramSendChat(), images: self.imageSendChat(), videos: [:]) { (response) in
            self.tvMsg.text = ""
            self.view.endEditing(true)
            self.getChat()
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            //            bottomConst.constant = (keyboardSize.height) * -1.0
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            //            bottomConst.constant = 0.0
            self.view.layoutIfNeeded()
        }
    }
}

extension UserChatVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMsgs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dict = arrMsgs[indexPath.row]
        let strDate = dict.dateTime ?? ""
        
        if let imageUrl = dict.chatImage, imageUrl != Router.BASE_IMAGE_URL {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatImageCell", for: indexPath) as! ChatImageCell
            cell.imgRight.isHidden = true
            cell.imgLeft.isHidden = true
            if let senderId = dict.senderId, senderId == k.userDefault.value(forKey: k.session.userId) as! String {
                cell.imgRight.isHidden = false
                Utility.setImageWithSDWebImage(dict.chatImage ?? "", cell.imgRight)
            } else {
                cell.imgLeft.isHidden = false
                Utility.setImageWithSDWebImage(dict.chatImage ?? "", cell.imgLeft)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell", for: indexPath) as! ConversationCell
            cell.chatLeft.isHidden = true
            cell.chatRight.isHidden = true
            
            if strDate != "0000-00-00 00:00:00" {
//                let formatter = DateFormatter()
//                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//                let date = formatter.date(from: strDate)
//                formatter.dateFormat = "dd MMM yyyy hh:mm a"
//                cell.lblDate.text = formatter.string(from: date!)
                cell.lblDate.text = strDate
            } else {
                cell.lblDate.text = ""
            }
            
            if let senderId = dict.senderId, senderId == k.userDefault.value(forKey: k.session.userId) as! String {
                let strImage = dict.senderDetail?.image ?? ""
                cell.imgRight.sd_setImage(with: URL.init(string: strImage), placeholderImage: UIImage.init(named: "Profile_Pla"), options: SDWebImageOptions(rawValue: 1), completed: nil)
                cell.chatRight.cornerRadius = cell.chatRight.frame.height / 2
                cell.chatRight.clipsToBounds = true
                cell.chatRight.isHidden = false
                cell.lblMsgRight.text = dict.chatMessage ?? ""
                cell.lblDate.textAlignment = .right
            } else {
                let strImage = dict.senderDetail?.image ?? ""
                cell.imgLeft.sd_setImage(with: URL.init(string: strImage), placeholderImage: UIImage.init(named: "Profile_Pla"), options: SDWebImageOptions(rawValue: 1), completed: nil)
                cell.chatLeft.cornerRadius = cell.chatRight.frame.height / 2
                cell.chatLeft.clipsToBounds = true
                cell.chatLeft.isHidden = false
                cell.lblMsgLeft.text = dict.chatMessage ?? ""
                cell.lblDate.textAlignment = .left
            }
            return cell
        }
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            if self.arrMsgs.count > 0 {
                let indexPath = IndexPath(row: self.arrMsgs.count-1, section: 0)
                self.tblView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
}

//MARK: TEXTVIEW DELEGATE
extension UserChatVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == tvMsg {
            if tvMsg.textColor == UIColor.white && tvMsg.text.count != 0 {
                tvMsg.text = ""
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == tvMsg {
            if tvMsg.text.count == 0 {
                tvMsg.text = R.string.localizable.sendMessage()
            }
        }
    }
}
