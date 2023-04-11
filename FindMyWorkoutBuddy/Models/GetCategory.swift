//
//  GetCategory.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 01/10/22.
//

import Foundation

struct ApiCategory : Codable {
    
    let result : [ResCategory]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([ResCategory].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResCategory : Codable {
    
    let id : String?
    let category_name : String?
    let image : String?
    let status : String?
    let display_order : String?
    let remove_status : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case category_name = "category_name"
        case image = "image"
        case status = "status"
        case display_order = "display_order"
        case remove_status = "remove_status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        category_name = try values.decodeIfPresent(String.self, forKey: .category_name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        display_order = try values.decodeIfPresent(String.self, forKey: .display_order)
        remove_status = try values.decodeIfPresent(String.self, forKey: .remove_status)
    }

}
