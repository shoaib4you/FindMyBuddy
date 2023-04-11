//
//  Notification.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 17/12/22.
//

import Foundation

struct ApiNotification : Codable {
    
    let result : [ResNotification]?
    let message : String?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        
        case result = "result"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([ResNotification].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResNotification : Codable {
    
    let id : String?
    let user_id : String?
    let other_user_id : String?
    let title : String?
    let message : String?
    let user_name : String?
    let date_time : String?
    let type : String?
    let user_type : String?
    let seen_status : String?
    let user_details : ResUserDetail?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case user_id = "user_id"
        case other_user_id = "other_user_id"
        case title = "title"
        case message = "message"
        case user_name = "user_name"
        case date_time = "date_time"
        case type = "type"
        case user_type = "user_type"
        case seen_status = "seen_status"
        case user_details = "user_details"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        other_user_id = try values.decodeIfPresent(String.self, forKey: .other_user_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        user_name = try values.decodeIfPresent(String.self, forKey: .user_name)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        user_type = try values.decodeIfPresent(String.self, forKey: .user_type)
        seen_status = try values.decodeIfPresent(String.self, forKey: .seen_status)
        user_details = try values.decodeIfPresent(ResUserDetail.self, forKey: .user_details)
    }
}
