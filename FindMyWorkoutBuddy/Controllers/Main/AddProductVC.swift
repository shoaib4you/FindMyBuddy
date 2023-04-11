//
//  AddPostVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 07/09/22.
//

import UIKit
import Gallery
import MapKit
import DropDown

class AddProductVC: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collec_Photo: UICollectionView!
    @IBOutlet weak var txtProductName: UITextField!
    @IBOutlet weak var txtProductPrice: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtLocationZipCode: UITextField!
    @IBOutlet weak var txtDesc: UITextField!
    @IBOutlet weak var btnCategory: UIButton!
    
    var address = ""
    var lat = 0.0
    var lon = 0.0
    var location_cordinate:CLLocationCoordinate2D?
    var arrImage:[[String: AnyObject]] = []
    var productId = ""
    var dpCategory = DropDown()
    var arrCategory = [String]()
    var arrCategoryId = [String]()
    var selectedCategoryId: String = ""
    var selectedCategoryName: String = ""
    var cloSuccess:(()->Void)?
    var object:ResGetAllProducts?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().selectedTextColor = UIColor.red
        DropDown.appearance().textFont = UIFont.systemFont(ofSize: 15)
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = hexStringToUIColor(hex: "#EBEBEB")
        DropDown.appearance().cellHeight = 40
        DropDown.appearance().cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getCategory()
        if let obj = object {
            self.lblTitle.text = R.string.localizable.updatePost()
            self.bindProduct(obj)
        }
    }
    
    func bindProduct(_ obj: ResGetAllProducts) {
        if obj.product_images?.count ?? 0 > 0 {
            if let arrImg = obj.product_images {
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
        self.productId = obj.id ?? ""
        if let catName = obj.cat_name {
            self.btnCategory.setTitle(catName, for: .normal)
            self.btnCategory.setTitleColor(.black, for: .normal)
            self.selectedCategoryId = obj.cat_id ?? ""
            self.selectedCategoryName = obj.cat_name ?? ""
        }
        self.txtProductName.text = obj.item_name ?? ""
        self.txtProductPrice.text = obj.item_price ?? ""
        self.txtLocationZipCode.text = obj.zip_code ?? ""
        self.txtLocation.text = obj.address ?? ""
        self.txtDesc.text = obj.description ?? ""
    }
    
    func getCategory() {
        Api.shared.getCategoryList(self, [:]) { (response) in
            if response.count > 0 {
                self.arrCategory = response.map({ $0.category_name ?? "" })
                self.arrCategoryId = response.map({ $0.id ?? "" })
                self.initDpCategory()
            } else {
                self.arrCategory = []
                self.arrCategoryId = []
            }
        }
    }
    
    func initDpCategory() {
        self.dpCategory.dataSource = self.arrCategory
        self.dpCategory.anchorView = self.btnCategory
        self.dpCategory.bottomOffset = CGPoint(x: 0, y: 45)
        self.dpCategory.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btnCategory.setTitle(item, for: .normal)
            self.btnCategory.setTitleColor(UIColor.black, for: .normal)
            self.selectedCategoryId = self.arrCategoryId[index]
            self.selectedCategoryName = item
        }
    }
    
    @IBAction func btnCategory(_ sender: UIButton) {
        self.dpCategory.show()
    }
    
    @IBAction func click_On_RestImage(_ sender: Any) {
        Config.Camera.recordLocation = true
        Config.Camera.imageLimit = 3
        Config.tabsToShow = [.imageTab, .cameraTab]
        let gallery = GalleryController()
        gallery.delegate = self
        present(gallery, animated: true, completion: nil)
    }
    
    @IBAction func btnPost(_ sender: UIButton) {
        // price > 0
        if let price = self.txtProductPrice.text {
            let nPrice = Int(price) ?? 0
            if nPrice > 0 {
                if (object != nil) {
                    self.updateProduct()
                } else {
                    self.addProducts()
                }
            } else {
                Utility.showAlertMessage(withTitle: k.appName, message: R.string.localizable.invalidPrice(), delegate: nil, parentViewController: self)
            }
        }
    }
    
    func paramAddPost() -> [String:String] {
        var dict : [String:String] = [:]
        if (object != nil) {
            dict["product_id"] = self.productId
        }
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as? String
        dict["cat_id"] = self.selectedCategoryId
        dict["cat_name"] = self.selectedCategoryName
        dict["item_name"] = self.txtProductName.text!
        dict["item_price"] = self.txtProductPrice.text!
        dict["timezone"] = localTimeZoneIdentifier
        dict["post_type"] = ""
        dict["description"] = self.txtDesc.text!
        dict["zip_code"] = self.txtLocationZipCode.text!
        dict["address"] = self.txtLocation.text!
        dict["lat"] = String(self.lat)
        dict["lon"] = String(self.lon)
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
        dict["product_images[]"] = paramImage
        return dict
    }
    
    func addProducts() {
        print(self.paramAddPost())
        print(self.imageDictAddOffers())
        Api.shared.addProduct(self, self.paramAddPost(), images: self.imageDictAddOffers(), videos: [:]) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.productAddedSuccessfully(), delegate: nil, parentViewController: self) { (boool) in
                self.cloSuccess?()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func updateProduct() {
        print(self.paramAddPost())
        print(self.imageDictAddOffers())
        Api.shared.updateProduct(self, self.paramAddPost(), images: self.imageDictAddOffers(), videos: [:]) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.productUpdatedSuccessfully(), delegate: nil, parentViewController: self) { (boool) in
                self.cloSuccess?()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func btnClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func paramDeleteImage(_ imageId: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["product_images_id"] = imageId as AnyObject
        return dict
    }
    
    func deleteImage(_ imageId: String) {
        Api.shared.deleteProductImage(self, self.paramDeleteImage(imageId)) { (response) in
            self.collec_Photo.reloadData()
        }
    }
}

extension AddProductVC: UICollectionViewDataSource {
    
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
        if self.object?.product_images?.count ?? 0 > button.tag {
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

extension AddProductVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 100, height: 100)
    }
}

extension AddProductVC: GalleryControllerDelegate {
    
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
