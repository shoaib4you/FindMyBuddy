//
//  ViewProfileVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 07/09/22.
//

import UIKit

class ViewProfileVC: UIViewController {

    @IBOutlet weak var imgUser: UIButton!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblFriends: UILabel!
    @IBOutlet weak var lblPosts: UILabel!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblNotificationCount: UILabel!
    @IBOutlet weak var lblAboutMe: UILabel!
    @IBOutlet weak var clvPhotos: UICollectionView!
    @IBOutlet weak var contraintCollectionHeight: NSLayoutConstraint!
    
    var identifier = "FeedImageCell"
    var arr:[ResUploadImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clvPhotos.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.getProfile()
        self.getUploadImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func getProfile() {
        Api.shared.getProfile(self) { (response) in
            if let image = response.image, image != Router.BASE_IMAGE_URL {
                Utility.downloadImageBySDWebImage(response.image ?? "") { (image, error) in
                    if error == nil {
                        self.imgUser.setImage(image, for: .normal)
                    }
                }
            }
            self.lblUserName.text = "\(response.first_name ?? "") \(response.last_name ?? "")"
            self.lblFriends.text = String(response.friend_count ?? 0) 
            self.lblPosts.text = String(response.feed_post_count ?? 0) 
            self.lblAddress.text = response.address ?? ""
           
            self.lblAboutMe.text = response.about_us ?? ""
            
            if let notiCount = response.noti_count, notiCount != "0" {
                self.lblNotificationCount.isHidden = false
                self.lblNotificationCount.text = "\(notiCount)"
            } else {
                self.lblNotificationCount.isHidden = true
            }
        }
    }
    
    func getUploadImage() {
        Api.shared.getUploadPhotos(self) { responseData in
            if responseData.count > 0 {
                self.arr = responseData
                if responseData.count % 2 == 0 {
                    self.contraintCollectionHeight.constant = CGFloat(((responseData.count / 2) * 160))
                } else {
                    self.contraintCollectionHeight.constant = CGFloat(((responseData.count / 2) * 160) + 160)
                }
            } else {
                self.arr = []
            }
            DispatchQueue.main.async {
                self.clvPhotos.reloadData()
                self.hideProgressBar()
            }
        }
    }
    
    @IBAction func btnEditProfile(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        vc.cloSuccess = {() in
            self.getProfile()
        }
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnMenu(_ sender: UIButton) {
        toggleLeft()
    }
    
    @IBAction func btnNotification(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewProfileVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.feedImageCell, for: indexPath)!
        cell.img.image = R.image.placeholder()
        Utility.setImageWithSDWebImage(self.arr[indexPath.row].image ?? "", cell.img)
        cell.btnReport.isHidden = true
//        cell.cloReport = {() in
//            self.reportUser(self.arr[indexPath.row].user_id ?? "", self.arr[indexPath.row].id ?? "")
//        }
        return cell
    }
}

extension ViewProfileVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.clvPhotos.frame.width / 2 , height: 160)
    }
}
