//
//  Constant.swift
//  Boom
//
//  Created by mac on 05/12/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

struct k {
    
    static let appName                          =   "Find My Workout Buddy"
    static var iosRegisterId                    =   "123456"
    static let emptyString                      =   ""
    static let userDefault                      =   UserDefaults.standard
    static let userType                         =   "CLIENT"
    static let screenSize                       =   UIScreen.main.bounds
    static let currency                         =   "$"
    static let themeColor                       =   "#77B743"
    static let navigationColor                  =   "#FFFFFF"
    static var cartCount                        =   0
    
    struct languages {
        struct english {
            static let urlTermsCondition        =   "https://techimmense.in/FMWB/terms_condition.html"
            static let urlPrivacyPolicy         =   "https://techimmense.in/FMWB/privacy_statement.html"
            static let urlAboutus               =   "https://techimmense.in/FMWB/about_us.html"
            static let urlhelp                  =   "https://www.google.com/"
            static let urlEULA                  =   "https://app.termly.io/document/eula/09a9b4d2-5988-4156-831a-9ed497dd354e"
        }
    }
    
    struct session {
        static let status                       =   "status"
        static let userId                       =   "user_id"
        static let userName                     =   "user_name"
        static let userEmail                    =   "user_email"
        static let userType                     =   "user_type"
        static let stripeCustomerId             =   "stripe_customer_id"
        static let catShortCode                 =   "service_type"
        static let onlineStatus                 =   "online_status"
        static let categoryId                   =   "category_id"
        static let subCategoryId                =   "sub_cat_id"
        static let userImage                    =   "user_image"
        static let interestedRestId             =   "interested_rest_id"
        static let lat                          =   "lat"
        static let lon                          =   "lon"
        static let restaurantName               =   "restaurant_name"
        static let userLogin                    =   "user_login"
        
        static let ads                          =   "ad"
        static let gambling                     =   "gambling"
        static let malware                      =   "malware"
        static let phishing                     =   "phishing"
        static let spyware                      =   "spyware"
        
        static let language                     =   "language"
        static let rejectCount                  =   "reject_count"
        static let currentCompanyId             =   "current_company_id"
    }
    
    struct google {
        static let googleApiKey                 =   "AIzaSyDnC9SccSvyLA5Hi6jvwX-by7l-kSi6BSg"
        static let googleClientId               =   ""
    }
    
    struct facebook {
        static let facebookId                   =   ""
    }
    
    struct sinch {
        static let sinchApplicationKey          =   ""
        static let sinchSecretKey               =   ""
        static let sinchHost                    =   ""
    }
    
    struct paypal {
        static let paypalClientId               =   ""
        static let sandboxAccount               =   ""
    }
    
    struct stripe {
        static let publisherKey                 =   "pk_test_itJKubyhNHEbYnr14cuuPZCh"
    }
    
    struct postCode {
        static let key                          =   "ak_k2ltpogjzBnjbH3DnVjHmZS5e1Ick"
    }
    
    static var menuWidth: CGFloat               =   0.0
    static var topMargin: CGFloat               =   0.0
}
