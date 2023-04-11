//
//  ReportUserVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 24/10/22.
//

import UIKit

class ReportUserVC: UIViewController {

    @IBOutlet weak var tableViewOt: UITableView!
    
    var identifier = "ReportUserCell"
    var arr:[ResReportedUser] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOt.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem(LeftTitle: "", LeftImage: "back", CenterTitle: R.string.localizable.reportUsers(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: k.themeColor, BackgroundImage: "", TextColor: "#FFFFFF", TintColor: "#FFFFFF", Menu: "")
        let lat = kAppDelegate.coordinate2.coordinate.latitude
        let lon = kAppDelegate.coordinate2.coordinate.longitude
        self.getReportedUsers(lat, lon)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func getReportedUsers(_ lat: Double, _ lon: Double) {
        Api.shared.getReportedUsers(self, self.paramGetNearestUser(lat, lon)) { responseData in
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
}

extension ReportUserVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.reportUserCell, for: indexPath)!
        let obj = self.arr[indexPath.row]
        Utility.setImageWithSDWebImage(obj.image ?? "", cell.img)
        cell.lblUsername.text = "\(obj.first_name ?? "") \(obj.last_name ?? "")"
        cell.lblDistance.text = "\(obj.distance ?? "") miles away"
        cell.lblDateTime.text = "Reported on \(obj.date_time ?? "")"
        
        return cell
    }
}

extension ReportUserVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}
