//
//  AppDelegate.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 01/09/22.
//

import UIKit
import MapKit
import IQKeyboardManagerSwift
import Firebase
import FirebaseMessaging
import Stripe
import GoogleSignIn

let kAppDelegate = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {
    
    var window: UIWindow?
    var CURRENT_LAT = ""
    var CURRENT_LON = ""
    var isValidLocation:Bool = true
    var coordinate1 = CLLocation(latitude: 0.0, longitude: 0.0)
    var coordinate2 = CLLocation(latitude: 0.0, longitude: 0.0)
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        UIApplication.shared.applicationIconBadgeNumber = 0
      
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        notificationCenter.delegate = self
        self.configureNotification()
        L102Localizer.DoTheMagic()
        StripeAPI.defaultPublishableKey = "pk_test_51L7FUEBzm3821Sh9xuLrUv53wZwlRocjT2UlfsKQWbBhquh1DjFlr0BBkOuvRdDCwjRn1EqYmFRgIsJN4XSJIHHi00TWWAbOp3"
        
        GIDSignIn.sharedInstance().clientID = "477782284816-ue92ptn0ol83skpg5potup4jnmj2tejd.apps.googleusercontent.com"
        // 2
        GIDSignIn.sharedInstance().delegate = self
        // 3
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.backgroundColor = R.color.theme_color()
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        
        Switcher.updateRootVC()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    func configureNotification() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
        }
        UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("FCM registration token: \(token)")
                k.iosRegisterId = token
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        k.iosRegisterId = deviceTokenString
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("APNs registration failed: \(error)")
    }
    
    // MARK:-  Received Remote Notification
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if let info = userInfo["aps"] as? Dictionary<String, AnyObject> {
            print(info)
        }
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {

        return GIDSignIn.sharedInstance().handle(url)
    }
}

extension AppDelegate: LocationManagerDelegate {
    
    func didEnterInCircularArea() {
        print("")
    }
    
    func didExitCircularArea() {
        print("")
    }
    
    
    func tracingLocation(currentLocation: CLLocation) {
        coordinate2 = currentLocation
        print(coordinate2)
        let distanceInMeters = coordinate1.distance(from: coordinate2) // result is in meters
        if distanceInMeters > 250 {
            CURRENT_LAT = String(currentLocation.coordinate.latitude)
            CURRENT_LON = String(currentLocation.coordinate.longitude)
            coordinate1 = currentLocation
            if let _ = UserDefaults.standard.value(forKey: "user_id") {
                //self.updateLatLon()
            }
        }
    }
    
    func tracingLocationDidFailWithError(error: NSError) {
        print("tracing Location Error : \(error.description)")
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Click detected")
        print(response)
        print(response.notification.request.content.userInfo)
        let userInfo = response.notification.request.content.userInfo
        //        self.redirectNotification(userInfo)
        completionHandler()
    }
    
    func showNotification(_ heading: String, _ message: String) {
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: heading, arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: message, arguments: nil)
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "driver_arrived"
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest.init(identifier: "notify-test", content: content, trigger: trigger)
        kAppDelegate.notificationCenter.add(request) { (errorr) in}
    }
    
    //    func redirectNotification(_ userInfo: Dictionary<AnyHashable, Any>) {
    //        if let info = userInfo["aps"] as? Dictionary<String, AnyObject> {
    //            let status = userInfo["gcm.notification.ios_status"] as? String
    //            print("Status Notification: ",status)
    //
    //            if status == "Request Accept" {
    //                if UIApplication.topViewController() != nil {
    //                    DispatchQueue.main.async {
    //                        self.handleRequestAccept()
    //                    }
    //                }
    //            } else if status == "You have a new message" {
    //                if UIApplication.topViewController() != nil {
    //                    DispatchQueue.main.async {
    //                        let receiverId = userInfo["gcm.notification.receiver_id"] as? String ?? ""
    //                        let userName = userInfo["gcm.notification.user_name"] as? String ?? ""
    //                        let requestId = userInfo["gcm.notification.request_id"] as? String ?? ""
    //
    //                        print(receiverId)
    //                        print(userName)
    //                        print(requestId)
    //                        self.handleChat(receiverId, userName, requestId)
    //                    }
    //                }
    //            } else {
    ////                if let rootViewController = UIApplication.topViewController() {
    ////                    let alertMsg = info["alert"]?["title"] as? String ?? ""
    ////                    Utility.showAlertMessage(withTitle: k.appName, message: alertMsg, delegate: nil, parentViewController: rootViewController)
    ////                }
    //                Switcher.updateRootVC()
    //            }
    //        }
    //    }
    //
    //    func handleRequestAccept() {
    //        let rootVC = R.storyboard.main().instantiateViewController(withIdentifier: "EmpOrderMainVC") as! EmpOrderMainVC
    //        let nav = UINavigationController(rootViewController: rootVC)
    //        nav.isNavigationBarHidden = false
    //        rootVC.isFromNotification = true
    //        kAppDelegate.window!.rootViewController = nav
    //        kAppDelegate.window?.makeKeyAndVisible()
    //    }
    //
    //    func handleChat(_ receiverId: String, _ userName: String, _ requestId: String) {
    //        let rootVC = R.storyboard.main().instantiateViewController(withIdentifier: "UserChatVC") as! UserChatVC
    //        let nav = UINavigationController(rootViewController: rootVC)
    //        nav.isNavigationBarHidden = false
    //        rootVC.isFromNotification = true
    //        rootVC.receiverId = receiverId
    //        rootVC.userName = userName
    //        rootVC.requestId = requestId
    //        kAppDelegate.window!.rootViewController = nav
    //        kAppDelegate.window?.makeKeyAndVisible()
    //    }
}

extension AppDelegate: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        // Check for sign in error
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }

        // Post notification after user successfully sign in
        NotificationCenter.default.post(name: .signInGoogleCompleted, object: nil)
    }
}

// MARK:- Notification names
extension Notification.Name {
    
    /// Notification when user successfully sign in using Google
    static var signInGoogleCompleted: Notification.Name {
        return .init(rawValue: #function)
    }
}
