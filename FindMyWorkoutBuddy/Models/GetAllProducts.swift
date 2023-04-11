//
//  GetAllProducts.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 19/09/22.
//

import Foundation

struct ApiGetAllProducts : Codable {
    
    let result : [ResGetAllProducts]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([ResGetAllProducts].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}


struct ResGetAllProducts : Codable {
    
    let id : String?
    let user_id : String?
    let cat_id : String?
    let cat_name : String?
    let item_name : String?
    let item_price : String?
    let description : String?
    let address : String?
    let lat : String?
    let lon : String?
    let zip_code : String?
    let date_time : String?
    let status : String?
    let remove_status : String?
    let product_images : [ResImages]?
    let user_details : ResUserDetails?
    let reported_product : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case cat_id = "cat_id"
        case cat_name = "cat_name"
        case item_name = "item_name"
        case item_price = "item_price"
        case description = "description"
        case address = "address"
        case lat = "lat"
        case lon = "lon"
        case zip_code = "zip_code"
        case date_time = "date_time"
        case status = "status"
        case remove_status = "remove_status"
        case reported_product = "reported_product"
        case product_images = "product_images"
        case user_details = "user_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        cat_id = try values.decodeIfPresent(String.self, forKey: .cat_id)
        cat_name = try values.decodeIfPresent(String.self, forKey: .cat_name)
        item_name = try values.decodeIfPresent(String.self, forKey: .item_name)
        item_price = try values.decodeIfPresent(String.self, forKey: .item_price)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        zip_code = try values.decodeIfPresent(String.self, forKey: .zip_code)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        remove_status = try values.decodeIfPresent(String.self, forKey: .remove_status)
        reported_product = try values.decodeIfPresent(String.self, forKey: .reported_product)
        product_images = try values.decodeIfPresent([ResImages].self, forKey: .product_images)
        user_details = try values.decodeIfPresent(ResUserDetails.self, forKey: .user_details)
    }
}
