//
//  MyItemsVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 06/09/22.
//

import UIKit

class MyItemsVC: UIViewController {

    @IBOutlet weak var tableViewOt: UITableView!
   // @IBOutlet weak var searchBar: UISearchBar!
    
    var identifier = "MyItemsCell"
    var arr:[ResGetAllProducts] = []
    var arrOrg:[ResGetAllProducts] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOt.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.getMyProducts()
        
//        delete_product
        
//        update_product
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func leftClick() {
        toggleLeft()
    }
    
    func getMyProducts() {
        Api.shared.getMyProducts(self) { responseData in
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
    
    func paramDeleteProduct(_ id: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["product_id"] = id as AnyObject
        return dict
    }
    
    func deleteProduct(_ id: String) {
        Api.shared.deleteProduct(self, self.paramDeleteProduct(id)) { (response) in
            self.getMyProducts()
        }
    }
}

extension MyItemsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.myItemsCell, for: indexPath)!
        let object = self.arr[indexPath.row]
        cell.btnStackMoreButton.isHidden = true
        cell.arr = []
        cell.clv.reloadData()
        if object.product_images?.count ?? 0 > 0 {
            cell.arr = object.product_images ?? []
            cell.clv.reloadData()
        }
        cell.lblItemName.text = object.item_name ?? ""
        cell.lblAddress.text = object.address ?? ""
        cell.lblDatetime.text = object.date_time ?? ""
        cell.lblItemPrice.text = object.item_price ?? ""
        
        cell.cloMore = {() in
            if cell.btnStackMoreButton.isHidden {
                cell.btnStackMoreButton.isHidden = false
            } else {
                cell.btnStackMoreButton.isHidden = true
            }
        }
        
        cell.cloEdit = {() in
            cell.btnStackMoreButton.isHidden = true
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "AddProductVC") as! AddProductVC
            vc.object = object
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            vc.cloSuccess = {() in
                self.getMyProducts()
            }
            self.present(vc, animated: true, completion: nil)
//            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        cell.cloDelete = {() in
            cell.btnStackMoreButton.isHidden = true
            Utility.showAlertYesNoAction(withTitle: k.appName, message: R.string.localizable.areYouSureYouWantToDeleteThisItem(), delegate: nil, parentViewController: self) { (bool) in
                if bool {
                    self.deleteProduct(object.id ?? "")
                }
            }
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

extension MyItemsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

//extension MyItemsVC: UISearchBarDelegate {
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        self.arr = self.arrOrg
//        if searchText != "" {
//            let filteredArr = self.arr.filter({ $0.item_name?.range(of: searchText, options: [.diacriticInsensitive, .caseInsensitive]) != nil } )
//            self.arr = filteredArr
//        }
//        self.tableViewOt.reloadData()
//    }
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        self.searchBar.endEditing(true)
//    }
//}
