//
//  FriendsVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 01/09/22.
//

import UIKit

class FriendsMainVC: UIViewController {

    @IBOutlet weak var vwList: UIView!
    @IBOutlet weak var btnList: UIButton!
    @IBOutlet weak var lblList: UILabel!
    @IBOutlet weak var vwMap: UIView!
    @IBOutlet weak var btnMap: UIButton!
    @IBOutlet weak var lblMap: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.vwMap.isHidden = true
        self.vwList.isHidden = false
        self.btnList.setTitleColor(R.color.theme_color(), for: .normal)
        self.btnMap.setTitleColor(.gray, for: .normal)
        self.lblMap.textColor = .white
        self.lblList.textColor = R.color.theme_color()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func btnMenu(_ sender: UIButton) {
        toggleLeft()
    }
    
    @IBAction func btnList(_ sender: UIButton) {
        self.vwMap.isHidden = true
        self.vwList.isHidden = false
        self.btnList.setTitleColor(R.color.theme_color(), for: .normal)
        self.btnMap.setTitleColor(.gray, for: .normal)
        self.lblMap.backgroundColor = .white
        self.lblList.backgroundColor = R.color.theme_color()
    }
    
    @IBAction func btnMap(_ sender: UIButton) {
        self.vwMap.isHidden = false
        self.vwList.isHidden = true
        self.btnList.setTitleColor(.gray, for: .normal)
        self.btnMap.setTitleColor(R.color.theme_color(), for: .normal)
        self.lblMap.backgroundColor = R.color.theme_color()
        self.lblList.backgroundColor = .white
    }
}
