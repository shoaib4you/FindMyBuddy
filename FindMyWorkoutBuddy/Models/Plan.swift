//
//  Plan.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 31/10/22.
//

import Foundation

struct ApiPlan : Codable {
    
    let result : [ResPlan]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([ResPlan].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResPlan : Codable {
    
    let id : String?
    let name : String?
    let name_gr : String?
    let price : String?
    let description : String?
    let description_gr : String?
    let month : String?
    let month_gr : String?
    let remove_status : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case name_gr = "name_gr"
        case price = "price"
        case description = "description"
        case description_gr = "description_gr"
        case month = "month"
        case month_gr = "month_gr"
        case remove_status = "remove_status"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        name_gr = try values.decodeIfPresent(String.self, forKey: .name_gr)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        description_gr = try values.decodeIfPresent(String.self, forKey: .description_gr)
        month = try values.decodeIfPresent(String.self, forKey: .month)
        month_gr = try values.decodeIfPresent(String.self, forKey: .month_gr)
        remove_status = try values.decodeIfPresent(String.self, forKey: .remove_status)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}
