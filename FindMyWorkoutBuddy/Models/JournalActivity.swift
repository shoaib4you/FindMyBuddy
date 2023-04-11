//
//  JournalActivity.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 16/11/22.
//

import Foundation

struct ApiJournalActivity : Codable {
    
    let result : [ResJournalActivity]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([ResJournalActivity].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResJournalActivity : Codable {
    
    let id : String?
    let user_id : String?
    let cat_id : String?
    let cat_name : String?
    let activity_name : String?
    let date : String?
    let from_time : String?
    let to_time : String?
    let image : String?
    let description : String?
    let status : String?
    let date_time : String?
    let user_details : ResUserDetails?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case cat_id = "cat_id"
        case cat_name = "cat_name"
        case activity_name = "activity_name"
        case date = "date"
        case from_time = "from_time"
        case to_time = "to_time"
        case image = "image"
        case description = "description"
        case status = "status"
        case date_time = "date_time"
        case user_details = "user_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        cat_id = try values.decodeIfPresent(String.self, forKey: .cat_id)
        cat_name = try values.decodeIfPresent(String.self, forKey: .cat_name)
        activity_name = try values.decodeIfPresent(String.self, forKey: .activity_name)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        from_time = try values.decodeIfPresent(String.self, forKey: .from_time)
        to_time = try values.decodeIfPresent(String.self, forKey: .to_time)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        user_details = try values.decodeIfPresent(ResUserDetails.self, forKey: .user_details)
    }
}

