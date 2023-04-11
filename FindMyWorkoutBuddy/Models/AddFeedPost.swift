//
//  AddFeedPost.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 28/10/22.
//

import Foundation

struct ApiAddFeedPost : Codable {
    
    let result : ResAddFeedPost?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(ResAddFeedPost.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResAddFeedPost : Codable {
    
    let id : String?
    let user_id : String?
    let description : String?
    let address : String?
    let lat : String?
    let lon : String?
    let zip_code : String?
    let post_type : String?
    let date_time : String?

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
    }
}
