//
//  GetConversion.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 05/10/22.
//

import Foundation

struct ApiGetConversion : Codable {
    
    let result : [ResGetConversion]?
    let status : String?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case status = "status"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([ResGetConversion].self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}

struct ResGetConversion : Codable {
    
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
    let no_of_message : Int?
    let last_message : String?
    let date : String?
    let sender_id : String?
    let receiver_id : String?

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
        case no_of_message = "no_of_message"
        case last_message = "last_message"
        case date = "date"
        case sender_id = "sender_id"
        case receiver_id = "receiver_id"
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
        no_of_message = try values.decodeIfPresent(Int.self, forKey: .no_of_message)
        last_message = try values.decodeIfPresent(String.self, forKey: .last_message)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        sender_id = try values.decodeIfPresent(String.self, forKey: .sender_id)
        receiver_id = try values.decodeIfPresent(String.self, forKey: .receiver_id)
    }

}
