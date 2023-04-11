//
//  MyFeedVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 01/09/22.
//

import UIKit

class MyFeedVC: UIViewController {

    @IBOutlet weak var tableViewOt: UITableView!
    
    var identifier = "MyFeedCell"
    var arr:[ResMyFeed] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOt.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.getMyFeed()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func btnMenu(_ sender: UIButton) {
        toggleLeft()
    }
    
    func getMyFeed() {
        Api.shared.getMyFeed(self) { responseData in
            if responseData.count > 0 {
                self.arr = responseData
            } else {
                self.arr = []
            }
            self.tableViewOt.reloadData()
        }
    }
    
    @IBAction func btnAddPost(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "AddNewPostVC") as! AddNewPostVC
        vc.cloSuccess = {() in
            self.getMyFeed()
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func likeUnlikeFeedPost(_ id: String) {
        Api.shared.likeUnlikeFeedPost(self, self.paramLikeUnlikeFeedPost(id)) { responseData in
            self.getMyFeed()
        }
    }
    
    func paramLikeUnlikeFeedPost(_ id: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId)! as AnyObject
        dict["feed_post_id"] = id as AnyObject
        return dict
    }
    
    func paramDeleteProduct(_ id: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["feed_post_id"] = id as AnyObject
        return dict
    }
    
    func deleteFeedPost(_ id: String) {
        Api.shared.deleteFeedPost(self, self.paramDeleteProduct(id)) { (response) in
            self.getMyFeed()
        }
    }
    
    @objc func labelTapped(_ sender: MyTapGesture) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "MarkerDetailVC") as! MarkerDetailVC
        vc.friendId = sender.userId
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MyFeedVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.myFeedCell, for: indexPath)!
        let object = self.arr[indexPath.row]
        Utility.addTapGesture(cell.lblUserName, self, object.user_details?.id ?? "")
        cell.lblUserName.text = "\(object.user_details?.first_name ?? "") \(object.user_details?.last_name ?? "")"
        cell.lblDatetime.text = object.date_time ?? ""
        if let img = object.user_details?.image, img != Router.BASE_IMAGE_URL {
            Utility.setImageWithSDWebImage(object.user_details?.image ?? "", cell.imgUser)
        }
        cell.lblPostDesc.text = object.description ?? ""
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
        
        if let count = object.feed_post_comment_count, count > 0 {
            if count == 1 {
                cell.btnComment.setTitle("\(object.feed_post_comment_count ?? 0) \(R.string.localizable.comment())", for: .normal)
            } else {
                cell.btnComment.setTitle("\(object.feed_post_comment_count ?? 0) \(R.string.localizable.comments())", for: .normal)
            }
        } else {
            cell.btnComment.setTitle("", for: .normal)
        }
        
        cell.cloComment = {() in
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "CommentsVC") as! CommentsVC
            vc.requestId = self.arr[indexPath.row].id ?? ""
            vc.senderId = k.userDefault.value(forKey: k.session.userId) as! String
            vc.cloSuccess = {() in
                self.getMyFeed()
            }
            self.present(vc, animated: true, completion: nil)
        }
        
        cell.cloMore = {() in
            if cell.btnStackMoreButton.isHidden {
                cell.btnStackMoreButton.isHidden = false
            } else {
                cell.btnStackMoreButton.isHidden = true
            }
        }
        
        cell.cloEdit = {() in
            cell.btnStackMoreButton.isHidden = true
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "AddNewPostVC") as! AddNewPostVC
            vc.object = object
            vc.postId = object.id ?? ""
            self.present(vc, animated: true, completion: nil)
        }
        
        cell.cloDelete = {() in
            cell.btnStackMoreButton.isHidden = true
            Utility.showAlertYesNoAction(withTitle: k.appName, message: R.string.localizable.areYouSureYouWantToDeleteThisItem(), delegate: nil, parentViewController: self) { (bool) in
                if bool {
                    self.deleteFeedPost(object.id ?? "")
                }
            }
        }
        return cell
    }
}
