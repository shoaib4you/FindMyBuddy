//
//  UserComments.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 25/12/22.
//

import Foundation

struct ApiComments : Codable {
    
    let result : [ResComments]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([ResComments].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResComments : Codable {
    
    let id : String?
    let user_id : String?
    let feed_post_id : String?
    let comment : String?
    let date_time : String?
    let user_details : ResUserDetails?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case feed_post_id = "feed_post_id"
        case comment = "comment"
        case date_time = "date_time"
        case user_details = "user_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        feed_post_id = try values.decodeIfPresent(String.self, forKey: .feed_post_id)
        comment = try values.decodeIfPresent(String.self, forKey: .comment)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        user_details = try values.decodeIfPresent(ResUserDetails.self, forKey: .user_details)
    }
}
