//
//  SubscriptionVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 01/09/22.
//

import UIKit

class SubscriptionVC: UIViewController {
    
    @IBOutlet weak var tableViewOt: UITableView!
    @IBOutlet weak var constraintTableHeight: NSLayoutConstraint!
    @IBOutlet weak var lblDesc: UILabel!
    
    var identifier = "PlanCell"
    var arr:[ResPlan] = []
    var selectedPlanId = ""
    var selectedPrice = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOt.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.getProfile()
        self.getPlan()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func getProfile() {
        Api.shared.getProfile(self) { responseData in
            if let planStatus = responseData.plan_status {
                if planStatus == "Plan Running" {
                    self.lblDesc.text = "\(R.string.localizable.months()) \(responseData.plan_details?.month ?? "") , \(R.string.localizable.thisIsYourCurrentActivePlan)"
                }
            }
        }
    }
    
    func getPlan() {
        Api.shared.getPlan(self) { responseData in
            if responseData.count > 0 {
                self.arr = responseData
                self.constraintTableHeight.constant = (CGFloat(self.arr.count * 90))
            } else {
                self.arr = []
            }
            self.tableViewOt.reloadData()
        }
    }
    
    @IBAction func btnMenu(_ sender: UIButton) {
        toggleLeft()
    }
    
    @IBAction func btnSubscribe(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "PaymentVC") as! PaymentVC
        vc.amount = Double(self.selectedPrice) ?? 0.0
        vc.planId = self.selectedPlanId
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SubscriptionVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.planCell, for: indexPath)!
        let obj = self.arr[indexPath.row]
        cell.img.image = R.image.radio_unchecked()
        cell.lblName.text = obj.name ?? ""
        cell.lblDesc.text = obj.description ?? ""
        cell.lblPrice.text = "\(k.currency) \(obj.price ?? "")"
        return cell
    }
}

extension SubscriptionVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PlanCell
        cell.img.image = R.image.radio_checked()
        self.selectedPlanId = self.arr[indexPath.row].id ?? ""
        self.selectedPrice = self.arr[indexPath.row].price ?? ""
        let indexPaths = tableView.indexPathsForVisibleRows
        for indexPathOth in indexPaths! {
            if indexPathOth.row != indexPath.row && indexPathOth.section == indexPath.section {
                let cell1 = tableView.cellForRow(at: IndexPath(row: indexPathOth.row, section: indexPathOth.section)) as! PlanCell
                cell1.img.image = R.image.radio_unchecked()
            }
        }
    }
}
