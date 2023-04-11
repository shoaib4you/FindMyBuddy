//
//  CommentsVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 25/12/22.
//

import UIKit
import SDWebImage

class CommentsVC: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tvMsg: UITextView!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var vwMsg: GradientView!
    @IBOutlet weak var btnPicture: UIButton!
    
    var arrMsgs:[ResComments] = []
    var requestId = ""
    var receiverId = ""
    var senderId = ""
    var userName = ""
    var refreshControl = UIRefreshControl()
    var image:UIImage?
    var isFromNotification = false
    var rating = 0.0
    var cloSuccess:(()->Void)?
    
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
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["feed_post_id"] = self.requestId as AnyObject
        dict["type"] = "NORMAL" as AnyObject
        return dict
    }
    
    @objc func getChat() {
        print(paramGetChat())
        Api.shared.getComments(self, self.paramGetChat()) { (response) in
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
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        self.cloSuccess?()
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
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as! String
        dict["sender_id"] = receiverId as? String
        dict["feed_post_id"] = self.requestId
        dict["type"] = "NORMAL"
        dict["comment"] = self.tvMsg.text!
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
        Api.shared.sendComment(self, self.paramSendChat(), images: self.imageSendChat(), videos: [:]) { (response) in
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

extension CommentsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMsgs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dict = arrMsgs[indexPath.row]
        let strDate = dict.date_time ?? ""
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as! CommentsCell
        cell.chatLeft.isHidden = true
        cell.chatRight.isHidden = true
        cell.lblDate.text = strDate
//        if strDate != "0000-00-00 00:00:00" {
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//            let date = formatter.date(from: strDate)
//            formatter.dateFormat = "dd MMM yyyy hh:mm a"
//            cell.lblDate.text = formatter.string(from: date!)
//        } else {
//            cell.lblDate.text = ""
//        }
        
        if let senderId = dict.user_id, senderId == k.userDefault.value(forKey: k.session.userId) as! String {
            let strImage = dict.user_details?.image ?? ""
            cell.imgRight.sd_setImage(with: URL.init(string: strImage), placeholderImage: UIImage.init(named: "Profile_Pla"), options: SDWebImageOptions(rawValue: 1), completed: nil)
            cell.chatRight.cornerRadius = cell.chatRight.frame.height / 2
            cell.chatRight.clipsToBounds = true
            cell.chatRight.isHidden = false
            cell.lblMsgRight.text = dict.comment ?? ""
            cell.lblDate.textAlignment = .right
        } else {
            let strImage = dict.user_details?.image ?? ""
            cell.imgLeft.sd_setImage(with: URL.init(string: strImage), placeholderImage: UIImage.init(named: "Profile_Pla"), options: SDWebImageOptions(rawValue: 1), completed: nil)
            cell.chatLeft.cornerRadius = cell.chatRight.frame.height / 2
            cell.chatLeft.clipsToBounds = true
            cell.chatLeft.isHidden = false
            cell.lblMsgLeft.text = dict.comment ?? ""
            cell.lblDate.textAlignment = .left
        }        
        return cell
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
extension CommentsVC: UITextViewDelegate {
    
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
