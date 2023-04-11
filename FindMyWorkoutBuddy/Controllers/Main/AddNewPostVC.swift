//
//  AddNewPostVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 07/09/22.
//

import UIKit
import Gallery
import MapKit

class AddNewPostVC: UIViewController {

    @IBOutlet weak var collec_Photo: UICollectionView!
    @IBOutlet weak var txtDesc: UITextField!
    
    var address = ""
    var lat = 0.0
    var lon = 0.0
    var location_cordinate:CLLocationCoordinate2D?
    var arrImage:[[String: AnyObject]] = []
    var object:ResMyFeed?
    var postId = ""
    var cloSuccess:(()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let obj = object {
            self.bindProduct(obj)
        }
    }
    
    func bindProduct(_ obj: ResMyFeed) {
        if obj.feed_post_images?.count ?? 0 > 0 {
            if let arrImg = obj.feed_post_images {
                for val in arrImg {
                    Utility.downloadImageBySDWebImage(val.image ?? "") { (image, error) in
                        if error == nil {
                            if let img = image {
//                                    self.arr_Image.append(img)
//                                    self.arr_Image_Url.append(val.image ?? "")
                                var dict : [String:AnyObject] = [:]
                                dict["image"] = img as AnyObject
                                dict["type"] = "server" as AnyObject
                                dict["id"] = val.id as AnyObject
                                self.arrImage.append(dict)
                                DispatchQueue.main.async {
                                    print(self.arrImage)
                                    self.collec_Photo.reloadData()
                                }
                            }
                        }
                    }
                }
            }
        }
        self.txtDesc.text = obj.description ?? ""
    }

    @IBAction func click_On_RestImage(_ sender: Any) {
        Config.Camera.recordLocation = true
        Config.Camera.imageLimit = 3
        Config.tabsToShow = [.imageTab, .cameraTab]
        let gallery = GalleryController()
        gallery.delegate = self
        present(gallery, animated: true, completion: nil)
    }
    
    @IBAction func btnClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnPost(_ sender: UIButton) {
        if (object != nil) {
            self.updateFeedPost()
        } else {
            self.addFeedPost()
        }
    }
    
    func paramAddPost() -> [String:String] {
        var dict : [String:String] = [:]
        if (object != nil) {
            dict["post_feed_id"] = self.postId
        }
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as? String
        dict["post_type"] = "Normal"
        dict["timezone"] = localTimeZoneIdentifier
        dict["description"] = self.txtDesc.text!
        return dict
    }
    
    func imageDictAddOffers() -> [String: Array<Any>] {
        var dict : [String: Array<Any>] = [:]
        var paramImage:[UIImage] = []
        if self.arrImage.count > 0 {
            for val in self.arrImage {
                if let type = val["type"] as? String, type == "local" {
                    paramImage.append(val["image"] as! UIImage)
                }
            }
        }
        dict["feed_post_images[]"] = paramImage
        return dict
    }
    
    func addFeedPost() {
        print(self.paramAddPost())
        print(self.imageDictAddOffers())
        Api.shared.addFeedPost(self, self.paramAddPost(), images: self.imageDictAddOffers(), videos: [:]) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.postAddedSuccessfully(), delegate: nil, parentViewController: self) { (boool) in
                self.cloSuccess?()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func updateFeedPost() {
        print(self.paramAddPost())
        print(self.imageDictAddOffers())
        Api.shared.updateFeedPost(self, self.paramAddPost(), images: self.imageDictAddOffers(), videos: [:]) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.postUpdatedSuccessfully(), delegate: nil, parentViewController: self) { (boool) in
                self.cloSuccess?()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func paramDeleteImage(_ imageId: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["feed_post_images_id"] = imageId as AnyObject
        return dict
    }
    
    func deleteFeedPostImages(_ imageId: String) {
        Api.shared.deleteFeedPostImages(self, self.paramDeleteImage(imageId)) { (response) in
            self.collec_Photo.reloadData()
        }
    }
}

extension AddNewPostVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCell
        if let img = arrImage[indexPath.row]["image"] as? UIImage {
            cell.btn_Image.setImage(img, for: .normal)
        }
        cell.btn_Image.tag = indexPath.row
        cell.btn_Image.addTarget(self, action: #selector(click_On_tab(button:)), for: .touchUpInside)
        
        cell.btn_cross.isHidden = false
        cell.btn_cross.tag = indexPath.row
        cell.btn_cross.addTarget(self, action: #selector(click_On_Cross(button:)), for: .touchUpInside)
        return cell
    }
    
    @objc func click_On_Cross(button:UIButton)  {
        print(button.tag)
        if self.object?.feed_post_images?.count ?? 0 > button.tag {
            if let type =  self.arrImage[button.tag]["type"] as? String, type == "server" {
                self.deleteFeedPostImages(self.arrImage[button.tag]["id"] as! String)
            }
        }
        arrImage.remove(at: button.tag)
        self.collec_Photo.reloadData()
    }
    
    @objc func click_On_tab(button:UIButton)  {
//        CameraHandler.shared.showActionSheet(vc: self)
//        CameraHandler.shared.imagePickedBlock = { (image) in
//            DispatchQueue.main.async {
//                self.arr_Image[button.tag] = image
//                self.collec_Photo.reloadData()
//            }
//        }
    }
}

extension AddNewPostVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 100, height: 100)
    }
}

extension AddNewPostVC: GalleryControllerDelegate {
    
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        
        Image.resolve(images: images, completion: { [weak self] resolvedImages in
            print(resolvedImages.compactMap({ $0 }))
            for img in resolvedImages {
                var dict : [String:AnyObject] = [:]
                dict["image"] = img as AnyObject
                dict["type"] = "local" as AnyObject
                self?.arrImage.append(dict)
            }
            self!.collec_Photo.reloadData()
        })
        self.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        print(video)
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        print([Image].self)
    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        self.dismiss(animated: true, completion: nil)
    }
}
