//
//  ProductDetailVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 15/01/23.
//

import UIKit

class ProductDetailVC: UIViewController {

    @IBOutlet weak var clv: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblProductType: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblSellerName: UILabel!
    @IBOutlet weak var lblSellerLastMessage: UILabel!
    @IBOutlet weak var imgSeller: UIImageView!
    
    var identifier = "FeedImageCell"
    var object: ResGetAllProducts?
    var arr:[ResImages] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clv.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        if let obj = object {
            if obj.product_images?.count ?? 0 > 0 {
                self.arr = obj.product_images ?? []
                self.pageControl.numberOfPages = obj.product_images?.count ?? 0
            } else {
                self.arr = []
            }
            self.clv.reloadData()
            self.lblProductName.text = obj.item_name ?? ""
            self.lblProductPrice.text = "\(k.currency)\(obj.item_price ?? "")"
            self.lblLocation.text = obj.address ?? ""
            self.lblProductType.text = obj.cat_name ?? ""
            self.lblDateTime.text = obj.date_time ?? ""
            self.lblDescription.text = obj.description ?? ""
            self.lblSellerName.text = "\(obj.user_details?.first_name ?? "") \(obj.user_details?.last_name ?? "")"
            self.lblSellerLastMessage.text = ""
            Utility.setImageWithSDWebImage(obj.user_details?.image ?? "", self.imgSeller)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "UserChatVC") as! UserChatVC
        vc.receiverId = self.object?.user_details?.id ?? ""
        vc.senderId = k.userDefault.value(forKey: k.session.userId) as! String
        vc.userName = "\(self.object?.user_details?.first_name ?? "") \(self.object?.user_details?.last_name ?? "")"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnChat(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "UserChatVC") as! UserChatVC
        vc.receiverId = self.object?.user_details?.id ?? ""
        vc.senderId = k.userDefault.value(forKey: k.session.userId) as! String
        vc.userName = "\(self.object?.user_details?.first_name ?? "") \(self.object?.user_details?.last_name ?? "")"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ProductDetailVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.feedImageCell, for: indexPath)!
        cell.img.image = R.image.placeholder()
        Utility.setImageWithSDWebImage(self.arr[indexPath.row].image ?? "", cell.img)
        return cell
    }
}

extension ProductDetailVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.clv.frame.width / 2 , height: 160)
    }
}

extension ProductDetailVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.row
    }
}
