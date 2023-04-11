//
//  PublicProductListVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 06/09/22.
//

import UIKit

class PublicProductListVC: UIViewController {

    @IBOutlet weak var tableViewOt: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var identifier = "PublicProductsCell"
    var arr:[ResGetAllProducts] = []
    var arrOrg:[ResGetAllProducts] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOt.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.getAllProducts()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func leftClick() {
        toggleLeft()
    }
    
    func getAllProducts() {
        Api.shared.getAllProducts(self) { responseData in
            if responseData.count > 0 {
                self.arr = responseData
                self.arrOrg = responseData
            } else {
                self.arr = []
                self.arrOrg = []
            }
            self.tableViewOt.reloadData()
        }
    }
    
    func paramReportUser(_ friendId: String, _ postId: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["report_user_id"] = friendId as AnyObject
        dict["product_id"] = postId as AnyObject
        return dict
    }
    
    func reportUser(_ friendId: String, _ postId: String) {
        print(self.paramReportUser(friendId, postId))
        Api.shared.reportedProduct(self, self.paramReportUser(friendId, postId)) { (response) in
            self.getAllProducts()
        }
    }
}

extension PublicProductListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.publicProductsCell, for: indexPath)!
        let object = self.arr[indexPath.row]
        if object.product_images?.count ?? 0 > 0 {
            cell.arr = object.product_images ?? []
            cell.clv.reloadData()
        }
        cell.lblItemName.text = object.item_name ?? ""
        cell.lblAddress.text = object.address ?? ""
        cell.lblDatetime.text = object.date_time ?? ""
        cell.lblItemPrice.text = object.item_price ?? ""
        if let status = object.reported_product, status == "Yes" {
            cell.btnReport.setTitle(R.string.localizable.reportedToAdmin(), for: .normal)
            cell.btnReport.isUserInteractionEnabled = false
        } else {
            cell.btnReport.setTitle(R.string.localizable.report(), for: .normal)
            cell.btnReport.isUserInteractionEnabled = true
        }
        
        cell.cloReport = {() in
            self.reportUser(object.user_details?.id ?? "", object.id ?? "")
        }
        
        cell.cloTappedOnImage = {() in
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ImageVC") as! ImageVC
            if object.product_images?.count ?? 0 > 0 {
                vc.image = object.product_images?[0].image ?? ""
            }
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
        return cell
    }
}

extension PublicProductListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
        vc.object = self.arr[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension PublicProductListVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.arr = self.arrOrg
        if searchText != "" {
            let filteredArr = self.arr.filter({ $0.item_name?.range(of: searchText, options: [.diacriticInsensitive, .caseInsensitive]) != nil || $0.zip_code?.range(of: searchText, options: [.diacriticInsensitive, .caseInsensitive]) != nil } )
            self.arr = filteredArr
        }
        self.tableViewOt.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}
