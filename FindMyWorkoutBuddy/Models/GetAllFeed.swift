//
//  GetAllFeed.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 19/09/22.
//

import Foundation

struct ApiGetAllFeed: Codable {
    
    let result : [ResGetAllFeed]?
    let message : String?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        
        case result = "result"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([ResGetAllFeed].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResGetAllFeed : Codable {
    
    let id : String?
    let user_id : String?
    let description : String?
    let address : String?
    let lat : String?
    let lon : String?
    let zip_code : String?
    let post_type : String?
    let date_time : String?
    let feed_post_like : String?
    let feed_post_images : [ResImages]?
    let user_details : ResUserDetails?
    let feed_post_count : Int?
    let feed_post_comment_count : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case user_id = "user_id"
        case description = "description"
        case address = "address"
        case lat = "lat"
        case lon = "lon"
        case zip_code = "zip_code"
        case post_type = "post_type"
        case date_time = "date_time"
        case feed_post_like = "feed_post_like"
        case feed_post_images = "feed_post_images"
        case user_details = "user_details"
        case feed_post_count = "feed_post_count"
        case feed_post_comment_count = "feed_post_comment_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        zip_code = try values.decodeIfPresent(String.self, forKey: .zip_code)
        post_type = try values.decodeIfPresent(String.self, forKey: .post_type)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        feed_post_like = try values.decodeIfPresent(String.self, forKey: .feed_post_like)
        feed_post_images = try values.decodeIfPresent([ResImages].self, forKey: .feed_post_images)
        user_details = try values.decodeIfPresent(ResUserDetails.self, forKey: .user_details)
        feed_post_count = try values.decodeIfPresent(Int.self, forKey: .feed_post_count)
        feed_post_comment_count = try values.decodeIfPresent(Int.self, forKey: .feed_post_comment_count)
    }
    
}

struct ResImages : Codable {
    
    let id : String?
    let feed_post_id : String?
    let image : String?
    let date_time : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case feed_post_id = "feed_post_id"
        case image = "image"
        case date_time = "date_time"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        feed_post_id = try values.decodeIfPresent(String.self, forKey: .feed_post_id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }
}

struct ResUserDetails : Codable {
    
    let id : String?
    let user_id : String?
    let first_name : String?
    let last_name : String?
    let user_name : String?
    let mobile : String?
    let email : String?
    let password : String?
    let image : String?
    let type : String?
    let code : String?
    let social_id : String?
    let lat : String?
    let lon : String?
    let address : String?
    let city : String?
    let register_id : String?
    let ios_register_id : String?
    let status : String?
    let date_time : String?
    let remove_status : String?
    let about_us : String?
    let wallet : String?
    let find_me : String?
    let can_see_profile : String?
    let exp_date : String?
    let plan_id : String?
    let profile_exp_date : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case user_id = "user_id"
        case first_name = "first_name"
        case last_name = "last_name"
        case user_name = "user_name"
        case mobile = "mobile"
        case email = "email"
        case password = "password"
        case image = "image"
        case type = "type"
        case code = "code"
        case social_id = "social_id"
        case lat = "lat"
        case lon = "lon"
        case address = "address"
        case city = "city"
        case register_id = "register_id"
        case ios_register_id = "ios_register_id"
        case status = "status"
        case date_time = "date_time"
        case remove_status = "remove_status"
        case about_us = "about_us"
        case wallet = "wallet"
        case find_me = "find_me"
        case can_see_profile = "can_see_profile"
        case exp_date = "exp_date"
        case plan_id = "plan_id"
        case profile_exp_date = "profile_exp_date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        user_name = try values.decodeIfPresent(String.self, forKey: .user_name)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        social_id = try values.decodeIfPresent(String.self, forKey: .social_id)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        register_id = try values.decodeIfPresent(String.self, forKey: .register_id)
        ios_register_id = try values.decodeIfPresent(String.self, forKey: .ios_register_id)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        remove_status = try values.decodeIfPresent(String.self, forKey: .remove_status)
        about_us = try values.decodeIfPresent(String.self, forKey: .about_us)
        wallet = try values.decodeIfPresent(String.self, forKey: .wallet)
        find_me = try values.decodeIfPresent(String.self, forKey: .find_me)
        can_see_profile = try values.decodeIfPresent(String.self, forKey: .can_see_profile)
        exp_date = try values.decodeIfPresent(String.self, forKey: .exp_date)
        plan_id = try values.decodeIfPresent(String.self, forKey: .plan_id)
        profile_exp_date = try values.decodeIfPresent(String.self, forKey: .profile_exp_date)
    }    
}
