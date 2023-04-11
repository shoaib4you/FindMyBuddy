//
//  UploadPhotosVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 23/03/23.
//

import UIKit
import Gallery

class UploadPhotosVC: UIViewController {
    
    @IBOutlet weak var collec_Photo: UICollectionView!
    
    var arrImage:[[String: AnyObject]] = []
    var arr:[ResUploadImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getUploadImage()
    }
    
    func getUploadImage() {
        Api.shared.getUploadPhotos(self) { responseData in
            if responseData.count > 0 {
                self.arr = responseData
                for val in responseData {
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
                                    self.hideProgressBar()
                                }
                            }
                        }
                    }
                }
            } else {
                self.arrImage = []
                self.arr = []
            }
            DispatchQueue.main.async {
                print(self.arrImage)
                self.collec_Photo.reloadData()
            }
        }
    }
    
    @IBAction func btnUploadPhotos(_ sender: UIButton) {
        Config.Camera.recordLocation = true
        Config.Camera.imageLimit = 3
        Config.tabsToShow = [.imageTab, .cameraTab]
        let gallery = GalleryController()
        gallery.delegate = self
        present(gallery, animated: true, completion: nil)
    }
    
    func paramDeleteImage(_ imageId: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["provider_image_id"] = imageId as AnyObject
        return dict
    }
    
    func deleteImage(_ imageId: String) {
        Api.shared.deleteUploadImage(self, self.paramDeleteImage(imageId)) { (response) in
            self.collec_Photo.reloadData()
        }
    }
    
    func paramAddPost() -> [String:String] {
        var dict : [String:String] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as? String
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
        dict["provider_images[]"] = paramImage
        return dict
    }
    
    func addPhotos() {
        Api.shared.addUploadPhotos(self, self.paramAddPost(), images: self.imageDictAddOffers(), videos: [:]) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.photosUploadedSuccessfully(), delegate: nil, parentViewController: self) { boool in
                self.getUploadImage()
            }
        }
    }
}

extension UploadPhotosVC: UICollectionViewDataSource {
    
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
        if self.arr.count > button.tag {
            if let type =  self.arrImage[button.tag]["type"] as? String, type == "server" {
                self.deleteImage(self.arrImage[button.tag]["id"] as! String)
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

extension UploadPhotosVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:( self.collec_Photo.frame.width / 2) - 10 , height: self.collec_Photo.frame.width / 2)
    }
}

extension UploadPhotosVC: GalleryControllerDelegate {
    
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        
        Image.resolve(images: images, completion: { [weak self] resolvedImages in
            print(resolvedImages.compactMap({ $0 }))
            for img in resolvedImages {
                var dict : [String:AnyObject] = [:]
                dict["image"] = img as AnyObject
                dict["type"] = "local" as AnyObject
                self?.arrImage.append(dict)
            }
            self?.addPhotos()
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
