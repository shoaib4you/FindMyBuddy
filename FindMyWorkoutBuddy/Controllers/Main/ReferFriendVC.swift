//
//  ReferFriendVC.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 01/09/22.
//

import UIKit

class ReferFriendVC: UIViewController {

    @IBOutlet weak var lblReferralCode: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.getProfile()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func getProfile() {
        Api.shared.getProfile(self) { responseData in
//            self.lblReferralCode.text = responseData.re
        }
    }
    
    @IBAction func btnMenu(_ sender: UIButton) {
        toggleLeft()
    }

    @IBAction func btnInvite(_ sender: UIButton) {
        self.doShare()
    }
    
    func doShare() {
        if let url = URL(string: "https://google.com"), !url.absoluteString.isEmpty {
            let shareText = "https://google.com"
            let shareItems: [Any] = [shareText, url]
            
            let activityVC = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
            activityVC.excludedActivityTypes = [.airDrop, .postToFlickr, .assignToContact, .openInIBooks]
            
            self.present(activityVC, animated: true, completion: nil)
        }
    }
}

