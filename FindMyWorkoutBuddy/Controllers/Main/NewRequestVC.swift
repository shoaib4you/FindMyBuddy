//
//  NewRequestVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 07/09/22.
//

import UIKit

class NewRequestVC: UIViewController {

    @IBOutlet weak var tableViewOt: UITableView!
    
    var identifier = "NewRequestCell"
    var arr:[ResFriendRequest] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOt.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        let lat = kAppDelegate.coordinate2.coordinate.latitude
        let lon = kAppDelegate.coordinate2.coordinate.longitude
        self.getNearestUser(lat, lon)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func getNearestUser(_ lat: Double, _ lon: Double) {
        Api.shared.getFriendRequest(self, self.paramGetNearestUser(lat, lon)) { responseData in
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
    
    
    func paramChangeFriendRequestStatus(_ id: String, _ status: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["friend_request_id"] = id as AnyObject
        dict["status"] = status as AnyObject
        dict["timezone"] = localTimeZoneIdentifier as AnyObject
        return dict
    }
    
    func changeFriendRequestStatus(_ id: String, _ status: String) {
        Api.shared.changeFriendRequestStatus(self, self.paramChangeFriendRequestStatus(id, status)) { responseData in
            let lat = kAppDelegate.coordinate2.coordinate.latitude
            let lon = kAppDelegate.coordinate2.coordinate.longitude
            self.getNearestUser(lat, lon)
        }
    }
}

extension NewRequestVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.newRequestCell, for: indexPath)!
        let obj = self.arr[indexPath.row]
        let object = obj.user_details
        if let image = object?.image, image != Router.BASE_IMAGE_URL {
            Utility.downloadImageBySDWebImage(object?.image ?? "") { (image, error) in
                if error == nil {
                    cell.img.image = image
                }
            }
        } else {
            cell.img.image = R.image.placeholder()
        }
        cell.lblUsername.text = "\(object?.first_name ?? "") \(object?.last_name ?? "")"
        cell.lblDistance.text = object?.distance ?? ""
        
        cell.cloAccept = {() in
            self.changeFriendRequestStatus(obj.id ?? "", "Accept")
        }
        
        cell.cloIgnore = {() in
            self.changeFriendRequestStatus(obj.id ?? "", "Ignore")
        }
        return cell
    }
}

extension NewRequestVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "MarkerDetailVC") as! MarkerDetailVC
        vc.friendId = self.arr[indexPath.row].id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
