//
//  MarkerDetailVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 17/10/22.
//

import UIKit

class MarkerDetailVC: UIViewController {
    
    @IBOutlet weak var imgUser: UIButton!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblAboutMe: UILabel!
    @IBOutlet weak var lblFriends: UILabel!
    @IBOutlet weak var lblPosts: UILabel!
    @IBOutlet weak var btnStackMoreButton: UIStackView!
    @IBOutlet weak var clv: UICollectionView!
    @IBOutlet weak var contraintCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var btnAddFriend: UIButton!
    @IBOutlet weak var btnMore: UIButton!
    
    var objRes: ResNearestUser?
    var arr:[ResFeedPost] = []
    var userId = ""
    var friendId = ""
    var userName = ""
    var identifier = "FeedImageCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clv.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        if let uId = k.userDefault.value(forKey: k.session.userId) as? String {
            if uId == self.friendId {
                self.btnMore.isHidden = true
            } else {
                self.btnMore.isHidden = false
            }
        }
        self.getProfile()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func getProfile() {
        Api.shared.getOtherProfile(self, self.paramGetProfile()) { response in
            if let image = response.image, image != Router.BASE_IMAGE_URL {
                Utility.downloadImageBySDWebImage(response.image ?? "") { (image, error) in
                    if error == nil {
                        self.imgUser.setImage(image, for: .normal)
                    }
                }
            }
            self.userName = "\(response.first_name ?? "") \(response.last_name ?? "")"
            self.lblUserName.text = "\(response.first_name ?? "") \(response.last_name ?? "")"
            self.lblFriends.text = String(response.friend_count ?? 0)
            self.lblPosts.text = String(response.feed_post_count ?? 0)
            self.lblAddress.text = response.address ?? ""
            self.lblAboutMe.text = response.about_us ?? ""
            if let posts = response.feed_post {
                if posts.count > 0 {
                    self.arr = posts
                    if posts.count % 2 == 0 {
                        self.contraintCollectionHeight.constant = CGFloat(((posts.count / 2) * 160))
                    } else {
                        self.contraintCollectionHeight.constant = CGFloat(((posts.count / 2) * 160) + 160)
                    }
                } else {
                    self.arr = []
                }
                self.clv.reloadData()
            }
            
            if let friendStatus = response.friend_status {
                if friendStatus == "Friend" || friendStatus == "Request Sent" || friendStatus == "Request Rejected" {
                    self.btnAddFriend.isHidden = true
                } else {
                    self.btnAddFriend.isHidden = false
                }
            }
        }
    }
    
    func paramGetProfile() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["friend_id"] = self.friendId as AnyObject
        dict["lat"] = "" as AnyObject
        dict["lon"] = "" as AnyObject
        return dict
    }
    
    @IBAction func btnMessage(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "UserChatVC") as! UserChatVC
        vc.receiverId = self.friendId
        vc.senderId = k.userDefault.value(forKey: k.session.userId) as! String
        vc.userName = self.userName
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnMore(_ sender: UIButton) {
        if self.btnStackMoreButton.isHidden {
            self.btnStackMoreButton.isHidden = false
        } else {
            self.btnStackMoreButton.isHidden = true
        }
    }
    
    @IBAction func btnReport(_ sender: UIButton) {
        self.reportUser()
    }
    
    func paramReportUser() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["report_user_id"] = self.friendId as AnyObject
        dict["time_zone"] = localTimeZoneIdentifier as AnyObject
        return dict
    }
    
    func reportUser() {
        Api.shared.reportUser(self, self.paramReportUser()) { (response) in
            Utility.showAlertMessage(withTitle: k.appName, message: response.message ?? "", delegate: nil, parentViewController: self)
        }
    }
    
    @IBAction func btnBlock(_ sender: UIButton) {
        self.blockUser()
    }
    
    func paramBlockUser() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["block_user_id"] = self.friendId as AnyObject
        dict["time_zone"] = localTimeZoneIdentifier as AnyObject
        return dict
    }
    
    func blockUser() {
        Api.shared.blockUnBlockUser(self, self.paramBlockUser()) { (response) in
            Utility.showAlertMessage(withTitle: k.appName, message: response.message ?? "", delegate: nil, parentViewController: self)
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
//        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddFriend(_ sender: UIButton) {
        Api.shared.addFriend(self, self.paramAddFriend()) { responseData in
            self.getProfile()
        }
    }
    
    func paramAddFriend() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["friend_id"] = self.friendId as AnyObject
        dict["time_zone"] = localTimeZoneIdentifier as AnyObject
        return dict
    }
    
    func paramReportUser(_ friendId: String, _ postId: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["report_user_id"] = friendId as AnyObject
        dict["post_id"] = postId as AnyObject
        return dict
    }
    
    func reportUser(_ friendId: String, _ postId: String) {
        print(self.paramReportUser(friendId, postId))
        Api.shared.reportedPost(self, self.paramReportUser(friendId, postId)) { (response) in
            Utility.showAlertWithAction(withTitle: k.appName, message: response.message ?? "", delegate: nil, parentViewController: self) { boool in
                self.getProfile()
            }
        }
    }
}

extension MarkerDetailVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.feedImageCell, for: indexPath)!
        cell.img.image = R.image.placeholder()
        if let obj = self.arr[indexPath.row].feed_post_images {
            if obj.count > 0 {
                Utility.setImageWithSDWebImage(obj[0].image ?? "", cell.img)
            }
        }
        
        cell.cloReport = {() in
            self.reportUser(self.arr[indexPath.row].user_id ?? "", self.arr[indexPath.row].id ?? "")
        }
        return cell
    }
}

extension MarkerDetailVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.clv.frame.width / 2 , height: 160)
    }
}
