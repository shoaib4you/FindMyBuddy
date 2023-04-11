//
//  BlockedUserVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 24/10/22.
//

import UIKit

class BlockedUserVC: UIViewController {

    @IBOutlet weak var tableViewOt: UITableView!
    
    var identifier = "BlockUserCell"
    var arr:[ResReportedUser] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOt.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "back", CenterTitle: R.string.localizable.blockedUsers(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        let lat = kAppDelegate.coordinate2.coordinate.latitude
        let lon = kAppDelegate.coordinate2.coordinate.longitude
        self.getBlockUsers(lat, lon)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func getBlockUsers(_ lat: Double, _ lon: Double) {
        Api.shared.getBlockUsers(self, self.paramGetNearestUser(lat, lon)) { responseData in
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
    
    func paramBlockUser(_ userId: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["block_user_id"] = userId as AnyObject
        dict["time_zone"] = localTimeZoneIdentifier as AnyObject
        return dict
    }
    
    func blockUser(_ userId: String) {
        Api.shared.blockUnBlockUser(self, self.paramBlockUser(userId)) { (response) in
            Utility.showAlertWithAction(withTitle: k.appName, message: response.message ?? "", delegate: nil, parentViewController: self) { bool in
                let lat = kAppDelegate.coordinate2.coordinate.latitude
                let lon = kAppDelegate.coordinate2.coordinate.longitude
                self.getBlockUsers(lat, lon)
            }
        }
    }
}

extension BlockedUserVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.blockUserCell, for: indexPath)!
        let obj = self.arr[indexPath.row]
        Utility.setImageWithSDWebImage(obj.image ?? "", cell.img)
        cell.lblUsername.text = "\(obj.first_name ?? "") \(obj.last_name ?? "")"
        cell.lblDistance.text = "\(obj.distance ?? "") miles away"
        cell.cloUnBlock = {() in
            self.blockUser(obj.id ?? "")
        }
        return cell
    }
}

extension BlockedUserVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}
