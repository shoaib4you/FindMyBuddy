//
//  Api.swift
//  ServiceProvider
//
//  Created by mac on 25/02/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class Api: NSObject {
    
    static let shared = Api()
    
    func paramGetUserId() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.string(forKey: k.session.userId)! as AnyObject
        return dict
    }
    
    func paramGetCompanyId() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["company_id"] = k.userDefault.string(forKey: k.session.userId)! as AnyObject
        return dict
    }
    
    func paramGetRestId() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["rest_id"] = k.userDefault.string(forKey: k.session.userId)! as AnyObject
        return dict
    }
    
//    func sendOtpSignUp(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiOtpForSignUp) -> Void) {
//        vc.blockUi()
//        Service.post(url: Router.sendOtpSignUp.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
//            do {
//                let decoder = JSONDecoder()
//                let root = try decoder.decode(ApiOtpForSignUp.self, from: response)
//                if root.status == "1" {
//                    if root.result != nil {
//                        success(root)
//                    }
//                } else {
//                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
//                }
//            } catch {
//                print(error)
//            }
//            vc.unBlockUi()
//        }) { (error: Error) in
//            vc.alert(alertmessage: error.localizedDescription)
//            vc.unBlockUi()
//        }
//    }
    
    func signup(_ vc: UIViewController, _ params: [String: String], images: [String : UIImage?]?, videos: [String : Data?]?, _ success: @escaping(_ responseData : ResLoginProfile) -> Void) {
        vc.blockUi()
        Service.postSingleMedia(url: Router.signUp.url(), params: params, imageParam: images, videoParam: videos, parentViewController: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiLoginProfile.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    k.userDefault.set(false, forKey: k.session.status)
                    k.userDefault.set(k.emptyString, forKey: k.session.userId)
                    k.userDefault.set(k.emptyString, forKey: k.session.userEmail)
                    k.userDefault.set(k.emptyString, forKey: k.session.stripeCustomerId)
                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func socialLogin(_ vc: UIViewController, _ params: [String: String], images: [String : UIImage?]?, videos: [String : Data?]?, _ success: @escaping(_ responseData : ResLoginProfile) -> Void) {
        vc.blockUi()
        Service.postSingleMedia(url: Router.socialLogin.url(), params: params, imageParam: images, videoParam: videos, parentViewController: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiLoginProfile.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    k.userDefault.set(false, forKey: k.session.status)
                    k.userDefault.set(k.emptyString, forKey: k.session.userId)
                    k.userDefault.set(k.emptyString, forKey: k.session.userEmail)
                    k.userDefault.set(k.emptyString, forKey: k.session.stripeCustomerId)
                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func login(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResLoginProfile) -> Void) {
        vc.blockUi()
        Service.post(url: Router.logIn.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiLoginProfile.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    k.userDefault.set(false, forKey: k.session.status)
                    k.userDefault.set(k.emptyString, forKey: k.session.userId)
                    k.userDefault.set(k.emptyString, forKey: k.session.userEmail)
                    k.userDefault.set(k.emptyString, forKey: k.session.stripeCustomerId)
                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getProfile(_ vc: UIViewController, _ success: @escaping(_ responseData : ResProfile) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getProfile.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiProfile.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getOtherProfile(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResUserDetail) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getUserInfo.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiUserDetails.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
//    func getProfileTerms(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResProfile) -> Void) {
//        vc.blockUi()
//        Service.post(url: Router.getProfile.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
//            do {
//                let decoder = JSONDecoder()
//                let root = try decoder.decode(ApiProfile.self, from: response)
//                if let result = root.result {
//                    success(result)
//                }
//                vc.unBlockUi()
//            } catch {
//                print(error)
//            }
//            vc.unBlockUi()
//        }) { (error: Error) in
//            vc.alert(alertmessage: error.localizedDescription)
//            vc.unBlockUi()
//        }
//    }
    
    func updateProfile(_ vc: UIViewController, _ params: [String: String], images: [String : UIImage?]?, videos: [String : Data?]?, _ success: @escaping(_ responseData : ResProfile) -> Void) {
        vc.blockUi()
        Service.postSingleMedia(url: Router.updateProfile.url(), params: params, imageParam: images, videoParam: videos, parentViewController: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiProfile.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func forgotPassword(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiBasic) -> Void) {
        vc.blockUi()
        Service.post(url: Router.forgotPassword.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getAllFeeds(_ vc: UIViewController, _ success: @escaping(_ responseData : [ResGetAllFeed]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getAllFeeds.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiGetAllFeed.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func likeUnlikeFeedPost(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiBasic) -> Void) {
        vc.blockUi()
        Service.post(url: Router.likeUnlikeFeedPost.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getAllProducts(_ vc: UIViewController, _ success: @escaping(_ responseData : [ResGetAllProducts]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getAllProducts.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiGetAllProducts.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func addProduct(_ vc: UIViewController, _ params: [String: String], images: [String : Array<Any>?]?, videos: [String : Array<Any>?]?, _ success: @escaping(_ responseData : ResAddProduct) -> Void) {
        vc.blockUi()
        Service.postWithMedia(url: Router.addProduct.url(), params: params, imageParam: images, videoParam: videos, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiAddProduct.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    //                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getCategoryList(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : [ResCategory]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getCategory.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiCategory.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getMyProducts(_ vc: UIViewController, _ success: @escaping(_ responseData : [ResGetAllProducts]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getMyProducts.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiGetAllProducts.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func deleteProduct(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiBasic) -> Void) {
        vc.blockUi()
        Service.post(url: Router.deleteProduct.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func deleteProductImage(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiBasic) -> Void) {
        vc.blockUi()
        Service.post(url: Router.deleteProductImage.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func updateProduct(_ vc: UIViewController, _ params: [String: String], images: [String : Array<Any>?]?, videos: [String : Array<Any>?]?, _ success: @escaping(_ responseData : ResAddProduct) -> Void) {
        vc.blockUi()
        Service.postWithMedia(url: Router.updateProduct.url(), params: params, imageParam: images, videoParam: videos, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiAddProduct.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getConversion(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : [ResGetConversion]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getConversion.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiGetConversion.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getChat(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : [ResChat]) -> Void) {
        Service.post(url: Router.getChat.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiChat.self, from: response)
                if let result = root.result {
                    success(result)
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func sendChat(_ vc: UIViewController, _ params: [String: String], images: [String : UIImage?]?,videos: [String : Data?]?, _ success: @escaping(_ responseData : ResSendChat) -> Void) {
        vc.blockUi()
        Service.postSingleMedia(url: Router.sendChat.url(), params: params, imageParam: images, videoParam: videos, parentViewController: vc, successBlock:  { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiSendChat.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getNearestUser(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : [ResNearestUser]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getNearestUser.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiNearestUser.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func blockUnBlockUser(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiBasic) -> Void) {
        vc.blockUi()
        Service.post(url: Router.blockUnBlockUser.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func deleteAccount(_ vc: UIViewController, _ success: @escaping(_ responseData : ApiBasic) -> Void) {
        vc.blockUi()
        Service.post(url: Router.deleteAccount.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func reportUser(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiBasic) -> Void) {
        vc.blockUi()
        Service.post(url: Router.reportUser.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func reportedPost(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiBasic) -> Void) {
        vc.blockUi()
        Service.post(url: Router.reportedPost.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func reportedProduct(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiBasic) -> Void) {
        vc.blockUi()
        Service.post(url: Router.reportedProduct.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getMyFeed(_ vc: UIViewController, _ success: @escaping(_ responseData : [ResMyFeed]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getMyFeed.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiMyFeed.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func deleteFeedPost(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiBasic) -> Void) {
        vc.blockUi()
        Service.post(url: Router.deleteFeedPost.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getMyBuddies(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : [ResNearestUser]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getMyBuddies.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiNearestUser.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getFriendRequest(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : [ResFriendRequest]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getFriendRequest.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiFriendRequest.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func changeFriendRequestStatus(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResChangeFriendRequestStatus) -> Void) {
        vc.blockUi()
        Service.post(url: Router.changeFriendRequestStatus.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiChangeFriendRequestStatus.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func updateFindMeStatus(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResProfile) -> Void) {
        vc.blockUi()
        Service.post(url: Router.updateFindMeStatus.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiProfile.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func sendFeedback(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResSendFeedback) -> Void) {
        vc.blockUi()
        Service.post(url: Router.sendFeedback.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiSendFeedback.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func addFeedPost(_ vc: UIViewController, _ params: [String: String], images: [String : Array<Any>?]?, videos: [String : Array<Any>?]?, _ success: @escaping(_ responseData : ResAddFeedPost) -> Void) {
        vc.blockUi()
        Service.postWithMedia(url: Router.addFeedPost.url(), params: params, imageParam: images, videoParam: videos, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiAddFeedPost.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func updateFeedPost(_ vc: UIViewController, _ params: [String: String], images: [String : Array<Any>?]?, videos: [String : Array<Any>?]?, _ success: @escaping(_ responseData : ResAddFeedPost) -> Void) {
        vc.blockUi()
        Service.postWithMedia(url: Router.updateFeedPost.url(), params: params, imageParam: images, videoParam: videos, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiAddFeedPost.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func deleteFeedPostImages(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiBasic) -> Void) {
        vc.blockUi()
        Service.post(url: Router.deleteFeedPostImages.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func stripePayment(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : AnyObject) -> Void) {
        vc.blockUi()
        Service.callPostService(apiUrl: Router.stripePayment.url(), parameters: params, Method: .get, parentViewController: vc, successBlock: { (response, message) in
            success(response)
            vc.unBlockUi()
        }) { (error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func addPayment(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResAddPayment) -> Void) {
        vc.blockUi()
        Service.post(url: Router.addPayment.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiAddPayment.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        vc.unBlockUi()
                        success(result)
                    }
                } else {
                    vc.unBlockUi()
                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getPlan(_ vc: UIViewController, _ success: @escaping(_ responseData : [ResPlan]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getPlan.url(), params: [:], method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiPlan.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func changePassword(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResLoginProfile) -> Void) {
        vc.blockUi()
        Service.post(url: Router.changePassword.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiLoginProfile.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        vc.unBlockUi()
                        success(result)
                    }
                } else {
                    vc.unBlockUi()
                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getReportedUsers(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : [ResReportedUser]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getReportedUsers.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiReportedUser.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getBlockUsers(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : [ResReportedUser]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getBlockUsers.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiReportedUser.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func canSeeProfile(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResProfile) -> Void) {
        vc.blockUi()
        Service.post(url: Router.canSeeProfile.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiProfile.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getJournalActivity(_ vc: UIViewController, _ success: @escaping(_ responseData : [ResJournalActivity]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getJournalActivity.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiJournalActivity.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func addActivity(_ vc: UIViewController, _ params: [String: String], images: [String : UIImage?]?, videos: [String : Data?]?, _ success: @escaping(_ responseData : ResAddActivity) -> Void) {
        vc.blockUi()
        Service.postSingleMedia(url: Router.addActivity.url(), params: params, imageParam: images, videoParam: videos, parentViewController: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiAddActivity.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func updateActivity(_ vc: UIViewController, _ params: [String: String], images: [String : UIImage?]?, videos: [String : Data?]?, _ success: @escaping(_ responseData : ResAddActivity) -> Void) {
        vc.blockUi()
        Service.postSingleMedia(url: Router.updateActivity.url(), params: params, imageParam: images, videoParam: videos, parentViewController: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiAddActivity.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getNotification(_ vc: UIViewController, _ success: @escaping(_ responseData : [ResNotification]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getNotification.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiNotification.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getComments(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : [ResComments]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getComments.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiComments.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func sendComment(_ vc: UIViewController, _ params: [String: String], images: [String : UIImage?]?,videos: [String : Data?]?, _ success: @escaping(_ responseData : ResSendComment) -> Void) {
        vc.blockUi()
        Service.postSingleMedia(url: Router.sendComments.url(), params: params, imageParam: images, videoParam: videos, parentViewController: vc, successBlock:  { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiSendComment.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getUserInfo(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : [ResFeedPosts]) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getUserInfo.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiUserInfo.self, from: response)
                if root.status == "1" {
                    if let result = root.result?.feed_post {
                        success(result)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func addFriend(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResAddFriend) -> Void) {
        vc.blockUi()
        Service.post(url: Router.addFriend.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiAddFriend.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func deleteGeneralActivity(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiBasic) -> Void) {
        vc.blockUi()
        Service.post(url: Router.deleteGeneralActivity.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func deleteAllNotification(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiBasic) -> Void) {
        vc.blockUi()
        Service.post(url: Router.deleteAllNotification.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func deleteSingleNotification(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiBasic) -> Void) {
        vc.blockUi()
        Service.post(url: Router.deleteSingleNotification.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getUploadPhotos(_ vc: UIViewController, _ success: @escaping(_ responseData : [ResUploadImage]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.getUploadPhotos.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiUploadPhotos.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.hideProgressBar()
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func deleteUploadImage(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiBasic) -> Void) {
        vc.blockUi()
        Service.post(url: Router.deleteUploadImage.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func addUploadPhotos(_ vc: UIViewController, _ params: [String: String], images: [String : Array<Any>?]?, videos: [String : Array<Any>?]?, _ success: @escaping(_ responseData : ApiBasicc) -> Void) {
        vc.showProgressBar()
        Service.postWithMedia(url: Router.addUploadPhotos.url(), params: params, imageParam: images, videoParam: videos, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasicc.self, from: response)
                if root.message != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
}
