//
//  FindBuddyListVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 06/09/22.
//

import UIKit

class FindBuddyListVC: UIViewController {

    @IBOutlet weak var tableViewOt: UITableView!
    
    var identifier = "FindBuddyListCell"
    var arr:[ResNearestUser] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOt.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        let lat = kAppDelegate.coordinate2.coordinate.latitude
        let lon = kAppDelegate.coordinate2.coordinate.longitude
        self.getNearestUser(lat,lon)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func getNearestUser(_ lat: Double, _ lon: Double) {
        Api.shared.getNearestUser(self, self.paramGetNearestUser(lat, lon)) { responseData in
            if responseData.count > 0 {
                self.arr = responseData
            } else {
                self.arr = []
            }
            self.tableViewOt.reloadData()
        }
    }
    
    func paramGetNearestUser(_ lat: Double, _ lon: Double) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["lat"] = lat as AnyObject
        dict["lon"] = lon as AnyObject
        return dict
    }
    
    override func leftClick() {
        toggleLeft()
    }
    
    @IBAction func btnFilter(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        vc.cloFilter = {(lat,lon,range) in
            self.getNearestUser(lat, lon)
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func labelTapped(_ sender: MyTapGesture) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "MarkerDetailVC") as! MarkerDetailVC
        vc.friendId = sender.userId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func paramBlockUser(_ friendId: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["block_user_id"] = friendId as AnyObject
        dict["time_zone"] = localTimeZoneIdentifier as AnyObject
        return dict
    }
    
    func blockUser(_ friendId: String) {
        Api.shared.blockUnBlockUser(self, self.paramBlockUser(friendId)) { (response) in
            Utility.showAlertWithAction(withTitle: k.appName, message: response.message ?? "", delegate: nil, parentViewController: self) { bool in
                let lat = kAppDelegate.coordinate2.coordinate.latitude
                let lon = kAppDelegate.coordinate2.coordinate.longitude
                self.getNearestUser(lat,lon)
            }            
        }
    }
}

extension FindBuddyListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.findBuddyListCell, for: indexPath)!
        let object = self.arr[indexPath.row]
        if let image = object.image, image != Router.BASE_IMAGE_URL {
            Utility.downloadImageBySDWebImage(object.image ?? "") { (image, error) in
                if error == nil {
                    cell.img.image = image
                }
            }
        }
        Utility.addTapGesture(cell.lblUsername, self, object.id ?? "")
        cell.lblUsername.text = "\(object.first_name ?? "") \(object.last_name ?? "")"
        cell.lblDistance.text = object.distance ?? ""
        
        cell.cloBlock = {() in
            self.blockUser(object.id ?? "")
        }
        return cell
    }
}

extension FindBuddyListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "MarkerDetailVC") as! MarkerDetailVC
        vc.friendId = self.arr[indexPath.row].id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
