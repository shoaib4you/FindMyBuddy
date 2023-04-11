//
//  LeftSideMenu.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 01/09/22.
//

import UIKit
import SlideMenuControllerSwift

enum LeftMenuRes: Int {
    case home = 0
    case myFeed
    case friends
    case journalActivity
//    case subscription
//    case referFriends
    case settings
    case logout
}

class LeftSideMenuVC: UIViewController {

    @IBOutlet weak var tableViewOt: UITableView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblProfileName: UILabel!
    
    var menuArrName = [
        R.string.localizable.home(),
        R.string.localizable.myFeed(),
        R.string.localizable.buddies(),
        R.string.localizable.journalActivity(),
//        R.string.localizable.subscription(),
//        R.string.localizable.referFriend(),
        R.string.localizable.settings(),
        R.string.localizable.logout()
    ]
    
    var arrImage = [
        R.image.feed_active(),
        R.image.myfeed(),
        R.image.friends(),
        R.image.journal_activity(),
//        R.image.subscription(),
//        R.image.sharefriend(),
        R.image.setting(),
        R.image.logout()
    ]
    
    var homeMain:UIViewController!
    var leftMenu:UIViewController!
    var homeViewController: UIViewController!
    var myMyFeedViewController: UIViewController!
    var friendsViewController: UIViewController!
    var journalActivityViewController: UIViewController!
    var subscriptionViewController: UIViewController!
    var referFriendViewController: UIViewController!
    var settingViewController: UIViewController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeMain = R.storyboard.main().instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.leftMenu = R.storyboard.main().instantiateViewController(withIdentifier: "LeftSideMenuVC") as! LeftSideMenuVC
        self.tableViewOt.register(UINib(nibName: "LeftSideMenuCell", bundle: nil), forCellReuseIdentifier: "LeftSideMenuCell")
        self.tableViewOt.tableFooterView = UIView(frame: CGRect.zero)
        
        let objResHomeVC = R.storyboard.main().instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.homeViewController = UINavigationController(rootViewController: objResHomeVC)
        
        let objMyFeedVC = R.storyboard.main().instantiateViewController(withIdentifier: "MyFeedVC") as! MyFeedVC
        self.myMyFeedViewController = UINavigationController(rootViewController: objMyFeedVC)
        
        let objFriendsVC = R.storyboard.main().instantiateViewController(withIdentifier: "FriendsMainVC") as! FriendsMainVC
        self.friendsViewController = UINavigationController(rootViewController: objFriendsVC)
        
        let objJournalActivityVC = R.storyboard.main().instantiateViewController(withIdentifier: "JournalActivityVC") as! JournalActivityVC
        self.journalActivityViewController = UINavigationController(rootViewController: objJournalActivityVC)
        
        let objSubscriptionVC = R.storyboard.main().instantiateViewController(withIdentifier: "SubscriptionVC") as! SubscriptionVC
        self.subscriptionViewController = UINavigationController(rootViewController: objSubscriptionVC)
        
        let objReferFriendVC = R.storyboard.main().instantiateViewController(withIdentifier: "ReferFriendVC") as! ReferFriendVC
        self.referFriendViewController = UINavigationController(rootViewController: objReferFriendVC)
        
        let objSettingVC = R.storyboard.main().instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        self.settingViewController = UINavigationController(rootViewController: objSettingVC)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        self.getProfile()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func getProfile() {
        Api.shared.getProfile(self) { responseData in
            self.lblProfileName.text = "\(responseData.first_name ?? "") \(responseData.last_name ?? "")"
            Utility.setImageWithSDWebImage(responseData.image ?? "", self.imgProfile)
        }
    }
    
    func changeController(_ index: Int) {
//        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ResHomeMainVC") as! ResHomeMainVC
//        vc.indexSelect = index
//        let rootVC = SlideMenuController(mainViewController: vc, rightMenuViewController: self.leftMenu)
//        kAppDelegate.window?.rootViewController = rootVC
//        kAppDelegate.window?.makeKeyAndVisible()
        
        let mainViewController = R.storyboard.main().instantiateViewController(withIdentifier: "HomeMainVC") as! HomeMainVC
        let leftViewController = R.storyboard.main().instantiateViewController(withIdentifier: "LeftSideMenuVC") as! LeftSideMenuVC
        let rootVC = SlideMenuController(mainViewController: mainViewController, leftMenuViewController: leftViewController)
        kAppDelegate.window?.rootViewController = rootVC
        kAppDelegate.window?.makeKeyAndVisible()
    }
    
    func changeViewController(_ menu: LeftMenuRes) {
        switch menu {
        case .home:
            self.changeController(0)
        case .myFeed:
            self.slideMenuController()?.changeMainViewController(self.myMyFeedViewController, close: true)
        case .friends:
            self.slideMenuController()?.changeMainViewController(self.friendsViewController, close: true)
        case .journalActivity:
            self.slideMenuController()?.changeMainViewController(self.journalActivityViewController, close: true)
//        case .subscription:
//            self.slideMenuController()?.changeMainViewController(self.subscriptionViewController, close: true)
//        case .referFriends:
//            self.slideMenuController()?.changeMainViewController(self.referFriendViewController, close: true)
        case .settings:
            self.slideMenuController()?.changeMainViewController(self.settingViewController, close: true)
        case .logout:
            self.logout()
        }
    }
    
    func doShare() {
        if let url = URL(string: "https://play.google.com/store/apps/details?id=main.com.hungrilahfood"), !url.absoluteString.isEmpty {
            let shareText = "https://play.google.com/store/apps/details?id=main.com.hungrilahfood"
            let shareItems: [Any] = [shareText, url]
            
            let activityVC = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
            activityVC.excludedActivityTypes = [.airDrop, .postToFlickr, .assignToContact, .openInIBooks]
            
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    func whatsapp() {
        let urlWhats = "whatsapp://send?phone=+966558885707&text="
        var characterSet = CharacterSet.urlQueryAllowed
        characterSet.insert(charactersIn: "?&")
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: characterSet){
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL){
                    UIApplication.shared.openURL(whatsappURL as URL)
                } else {
                    print("Install Whatsapp")
                }
            }
        }
    }
    
    @IBAction func btnLogout(_ sender: UIButton) {
        self.logout()
    }
    
    func logout() {
        let alertController = UIAlertController(title: k.appName, message: R.string.localizable.areYouSureYouWantToLogOut(), preferredStyle: .alert)
        let yesAction: UIAlertAction = UIAlertAction(title: R.string.localizable.yes(), style: .default) { action -> Void in
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            Switcher.updateRootVC()
        }
        let noAction: UIAlertAction = UIAlertAction(title: R.string.localizable.no(), style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension LeftSideMenuVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArrName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.leftSideMenuCell, for: indexPath)!
        cell.txt.text = menuArrName[indexPath.row]
        cell.img.image = self.arrImage[indexPath.row]
        if indexPath.row == 5 {
            cell.txt.textColor = .red
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}

extension LeftSideMenuVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        k.userDefault.set(false, forKey: k.session.catShortCode)
        if let menu = LeftMenuRes(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
    }
}
