//
//  Router.swift
//  ServiceProvider
//
//  Created by mac on 12/03/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation


enum Router: String {
    
    static let BASE_SERVICE_URL = "https://findmyworkoutbuddy.app/FMWB/webservice/"
    static let BASE_IMAGE_URL = "https://findmyworkoutbuddy.app/FMWB/uploads/images/"
    static let BASE_URL_POSTCODE = ""
    
    case logIn
    case signUp
    case getProfile
    case socialLogin
    case forgotPassword
    case updateProfile
    case changePassword
    case verifyOtp
    case sendOtpSignUp
    
    case getAllFeeds
    case likeUnlikeFeedPost
    
    case getAllProducts
    case addProduct
    case getCategory
    case getMyProducts
    case deleteProduct
    case deleteProductImage
    case updateProduct
    
    case getConversion
    case getChat
    case sendChat
    
    case getNearestUser
    case blockUnBlockUser
    case reportUser
    case reportedPost
    case reportedProduct
    
    case getMyFeed
    case addFeedPost
    case updateFeedPost
    case deleteFeedPost
    case deleteFeedPostImages
    
    case getMyBuddies
    case getFriendRequest
    case changeFriendRequestStatus
    
    case updateFindMeStatus
    case sendFeedback
    
    case stripePayment
    case addPayment
    
    case getPlan
    case getReportedUsers
    case getBlockUsers
    case canSeeProfile
    
    case addActivity
    case updateActivity
    case getJournalActivity
    case getNotification
    case getComments
    case sendComments
    
    case getUserInfo
    case addFriend
    case getUserPlan
    
    case deleteAccount
    
    case deleteAllNotification
    case deleteSingleNotification
    case deleteGeneralActivity
    
    case getUploadPhotos
    case deleteUploadImage
    case addUploadPhotos
    
    public func url() -> String {
        switch self {
        case .logIn:
            return Router.oAuthRoute(path: "login")
        case .forgotPassword:
            return Router.oAuthRoute(path: "forgot_password")
        case .signUp:
            return Router.oAuthRoute(path: "signup")
        case .socialLogin:
            return Router.oAuthRoute(path: "social_login")
        case .getProfile:
            return Router.oAuthRoute(path: "get_profile")
        case .updateProfile:
            return Router.oAuthRoute(path: "update_profile")
        case .changePassword:
            return Router.oAuthRoute(path: "change_password")
        case .verifyOtp:
            return Router.oAuthRoute(path: "verify_number")
        case .sendOtpSignUp:
            return Router.oAuthRoute(path: "verify_number")
            
        case .getAllFeeds:
            return Router.oAuthRoute(path: "get_all_feed_post")
        case .likeUnlikeFeedPost:
            return Router.oAuthRoute(path: "like_unlike_feed_post")
            
        case .getAllProducts:
            return Router.oAuthRoute(path: "get_all_product")
        case .addProduct:
            return Router.oAuthRoute(path: "add_product")
        case .getCategory:
            return Router.oAuthRoute(path: "get_category")
        case .getMyProducts:
            return Router.oAuthRoute(path: "get_my_product")
        case .deleteProduct:
            return Router.oAuthRoute(path: "delete_product")
        case .deleteProductImage:
            return Router.oAuthRoute(path: "delete_product_image")
        case .updateProduct:
            return Router.oAuthRoute(path: "update_product")
            
        case .getConversion:
            return Router.oAuthRoute(path: "get_conversation_detail")
        case .getChat:
            return Router.oAuthRoute(path: "get_chat_detail")
        case .sendChat:
            return Router.oAuthRoute(path: "insert_chat")
            
        case .getNearestUser:
            return Router.oAuthRoute(path: "get_nearest_user")
        case .blockUnBlockUser:
            return Router.oAuthRoute(path: "block_unblock_user")
        case .reportUser:
            return Router.oAuthRoute(path: "report_user")
        case .reportedPost:
            return Router.oAuthRoute(path: "reported_post")
        case .reportedProduct:
            return Router.oAuthRoute(path: "reported_product")
            
        case .getMyFeed:
            return Router.oAuthRoute(path: "get_my_feed_post")
        case .addFeedPost:
            return Router.oAuthRoute(path: "add_feed_post")
        case .updateFeedPost:
            return Router.oAuthRoute(path: "update_feed_post")
        case .deleteFeedPost:
            return Router.oAuthRoute(path: "delete_feed_post")
        case .deleteFeedPostImages:
            return Router.oAuthRoute(path: "delete_feed_post_image")
            
        case .getMyBuddies:
            return Router.oAuthRoute(path: "my_friend_list")
        case .getFriendRequest:
            return Router.oAuthRoute(path: "received_friend_request")
        case .changeFriendRequestStatus:
            return Router.oAuthRoute(path: "change_friend_request_status")
            
        case .updateFindMeStatus:
            return Router.oAuthRoute(path: "update_find_me_status")
        case .sendFeedback:
            return Router.oAuthRoute(path: "send_feedback")
            
        case .stripePayment:
            return Router.oAuthRoute(path: "strip_payment")
        case .addPayment:
            return Router.oAuthRoute(path: "plan_purchase")
            
        case .getPlan:
            return Router.oAuthRoute(path: "get_plan_list")
        case .getReportedUsers:
            return Router.oAuthRoute(path: "get_reported_users_list")
        case .getBlockUsers:
            return Router.oAuthRoute(path: "get_blocked_user_list")
        case .canSeeProfile:
            return Router.oAuthRoute(path: "update_can_see_profile_status")
            
        case .addActivity:
            return Router.oAuthRoute(path: "add_general_activity")
        case .updateActivity:
            return Router.oAuthRoute(path: "update_general_activity")
        case .getJournalActivity:
            return Router.oAuthRoute(path: "get_my_general_activity")
        case .getNotification:
            return Router.oAuthRoute(path: "get_notification_list")
        case .getComments:
            return Router.oAuthRoute(path: "get_feed_post_comment")
            
        case .sendComments:
            return Router.oAuthRoute(path: "add_feed_post_comment")
        case .getUserInfo:
            return Router.oAuthRoute(path: "get_user_details")
        case .addFriend:
            return Router.oAuthRoute(path: "add_friend_request")
        case .getUserPlan:
            return Router.oAuthRoute(path: "get_user_plan")
            
        case .deleteAccount:
            return Router.oAuthRoute(path: "delete_user_account")
            
        case .deleteAllNotification:
            return Router.oAuthRoute(path: "delete_all")
        case .deleteSingleNotification:
            return Router.oAuthRoute(path: "delete_one")
        case .deleteGeneralActivity:
            return Router.oAuthRoute(path: "delete_general_activity")
            
        case .getUploadPhotos:
            return Router.oAuthRoute(path: "get_provider_image_list")
        case .deleteUploadImage:
            return Router.oAuthRoute(path: "delete_provider_image_new")
        case .addUploadPhotos:
            return Router.oAuthRoute(path: "add_provider_image")
        }
    }
    
    private static func oAuthRoute(path: String) -> String {
        return Router.BASE_SERVICE_URL + path
    }
    
}
