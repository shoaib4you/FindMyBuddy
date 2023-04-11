//
//  JournalActivityVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 01/09/22.
//

import UIKit

class JournalActivityVC: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var tableViewOt: UITableView!
    
    var identifier = "JournalActivityCell"
    var arr:[ResJournalActivity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOt.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.getReportedUsers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    func getReportedUsers() {
        Api.shared.getJournalActivity(self) { responseData in
            if responseData.count > 0 {
                self.arr = responseData
            } else {
                self.arr = []
            }
            self.tableViewOt.reloadData()
        }
    }
    
    @IBAction func btnAdd(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "AddActivityVC") as! AddActivityVC
        vc.cloSuccess = {() in
            self.getReportedUsers()
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnMenu(_ sender: UIButton) {
        toggleLeft()
    }
    
    func delete(_ id: String) {
        Api.shared.deleteGeneralActivity(self, self.paramDelete(id), { responseData in
            self.getReportedUsers()
        })
    }
    
    func paramDelete(_ id: String) -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["id"] = id as AnyObject
        return dict
    }
}

extension JournalActivityVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.journalActivityCell, for: indexPath)!
        let obj = self.arr[indexPath.row]
        cell.lblUsername.text = "\(obj.activity_name ?? "")"
        cell.lblDistance.text = "\(obj.date ?? "")"
        cell.lblDateTime.text = "\(obj.from_time ?? "") \(obj.to_time ?? "")"
        
        cell.cloDelete = {() in
            self.delete(obj.id ?? "")
        }
        return cell
    }
}

extension JournalActivityVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "AddActivityVC") as! AddActivityVC
        vc.obj = self.arr[indexPath.row]
        vc.cloSuccess = {() in
            self.getReportedUsers()
        }
        self.present(vc, animated: true, completion: nil)
    }
}
