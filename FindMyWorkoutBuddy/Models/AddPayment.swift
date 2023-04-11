//
//  AddPayment.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 15/01/23.
//

import Foundation

struct ApiAddPayment : Codable {
    
    let result : ResAddPayment?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(ResAddPayment.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResAddPayment : Codable {
    
    let id : String?
    let user_id : String?
    let plan_id : String?
    let transaction_id : String?
    let amount : String?
    let type : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case plan_id = "plan_id"
        case transaction_id = "transaction_id"
        case amount = "amount"
        case type = "type"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        plan_id = try values.decodeIfPresent(String.self, forKey: .plan_id)
        transaction_id = try values.decodeIfPresent(String.self, forKey: .transaction_id)
        amount = try values.decodeIfPresent(String.self, forKey: .amount)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}
