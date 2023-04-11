//
//  HomeVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 01/09/22.
//

import UIKit
import simd

class HomeVC: UIViewController {

    @IBOutlet weak var tableViewOt: UITableView!
    @IBOutlet weak var lblNotificationCount: UILabel!
    
    var identifier = "FeedPostCell"
    var arr:[ResGetAllFeed] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOt.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        print(k.userDefault.value(forKey: k.session.userId))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.getProfile()
        self.getAllFeeds()
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
    
    func getAllFeeds() {
        Api.shared.getAllFeeds(self) { responseData in
            if responseData.count > 0 {
                self.arr = responseData
            } else {
                self.arr = []
            }
            self.tableViewOt.reloadData()
        }
    }
    
    @IBAction func btnMenu(_ sender: UIButton) {
//        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "UserChatVC") as! UserChatVC
//        vc.receiverId = "8"
//        vc.senderId = "10"
//        vc.userName = "sadfsdf"
//        self.navigationController?.pushViewController(vc, animated: true)
        toggleLeft()
    }
    
    @IBAction func btnAdd(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "AddNewPostVC") as! AddNewPostVC
        vc.cloSuccess = {() in
            self.getAllFeeds()
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func likeUnlikeFeedPost(_ id: String) {
        Api.shared.likeUnlikeFeedPost(self, self.paramLikeUnlikeFeedPost(id)) { responseData in
            self.getAllFeeds()
        }
    }
    
    func paramLikeUnlikeFeedPost(_ id: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId)! as AnyObject
        dict["feed_post_id"] = id as AnyObject
        return dict
    }
    
    @IBAction func btnNotification(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func paramReportUser(_ friendId: String, _ postId: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["report_user_id"] = friendId as AnyObject
        dict["post_id"] = postId as AnyObject
        return dict
    }
    
    func reportUser(_ friendId: String, _ postId: String) {
        Api.shared.reportedPost(self, self.paramReportUser(friendId, postId)) { (response) in
            Utility.showAlertWithAction(withTitle: k.appName, message: response.message ?? "", delegate: nil, parentViewController: self) { boool in
                self.getAllFeeds()
            }
        }
    }
}

extension HomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.feedPostCell, for: indexPath)!
        let object = self.arr[indexPath.row]
        cell.lblUserName.text = "\(object.user_details?.first_name ?? "") \(object.user_details?.last_name ?? "")"
        cell.lblDatetime.text = object.date_time ?? ""
        if let img = object.user_details?.image, img != Router.BASE_IMAGE_URL {
            Utility.setImageWithSDWebImage(object.user_details?.image ?? "", cell.imgUser)
        }
        cell.lblPostDesc.text = object.description ?? ""
        if let count = object.feed_post_comment_count, count > 0 {
            if count == 1 {
                cell.btnComment.setTitle("\(object.feed_post_comment_count ?? 0) \(R.string.localizable.comment())", for: .normal)
            } else {
                cell.btnComment.setTitle("\(object.feed_post_comment_count ?? 0) \(R.string.localizable.comments())", for: .normal)
            }
        } else {
            cell.btnComment.setTitle("", for: .normal)
        }
        if object.feed_post_images?.count ?? 0 > 0 {
            cell.clv.isHidden = false
            cell.arr = object.feed_post_images ?? []
            cell.clv.reloadData()
        } else {
            cell.clv.isHidden = true
        }
        if let count = object.feed_post_count, count > 0 {
            cell.btnLike.setTitle("\(R.string.localizable.likedBy()) \(object.feed_post_count ?? 0)", for: .normal)
        } else {
            cell.btnLike.setTitle("", for: .normal)
        }
        if let likeUnLike = object.feed_post_like, likeUnLike == "Yes" {
            cell.btnLike.setImage(R.image.like(), for: .normal)
        } else {
            cell.btnLike.setImage(R.image.unlike(), for: .normal)
        }
        cell.cloLike = {() in
            self.likeUnlikeFeedPost(object.id ?? "")
        }
        
        cell.btnReport.setTitle(R.string.localizable.report(), for: .normal)
        
        cell.cloComment = {() in
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "CommentsVC") as! CommentsVC
            vc.requestId = self.arr[indexPath.row].id ?? ""
            vc.senderId = k.userDefault.value(forKey: k.session.userId) as! String
            vc.cloSuccess = {() in
                self.getAllFeeds()
            }
            self.present(vc, animated: true, completion: nil)
        }
        
        cell.cloUserProfile = {() in
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "MarkerDetailVC") as! MarkerDetailVC
            vc.friendId = self.arr[indexPath.row].user_details?.id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        cell.cloTappedOnImage = {() in
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ImageVC") as! ImageVC
            if object.feed_post_images?.count ?? 0 > 0 {
                vc.image = object.feed_post_images?[0].image ?? ""
            }
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
        cell.cloReport = {() in
            self.reportUser(object.user_details?.id ?? "", object.id ?? "")
        }
        return cell
    }
}
