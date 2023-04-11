//
//  Chat.swift
//  FindMyWorkoutBuddy
//
//  Created by Techimmense Software Solutions on 05/10/22.
//

import Foundation

struct ApiChat : Codable {
    
    let message : String?
    let result : [ResChat]?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case result = "result"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        result = try values.decodeIfPresent([ResChat].self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResChat : Codable {
    
    let chatImage : String?
    let chatMessage : String?
    let clearChat : String?
    let dateTime : String?
    let id : String?
    let receiverDetail : ResReceiverDetail?
    let receiverId : String?
    let requestId : String?
    let result : String?
    let senderDetail : ResSenderDetail?
    let senderId : String?
    let status : String?
    let timezone : String?
    let type : String?
    
    enum CodingKeys: String, CodingKey {
        case chatImage = "chat_image"
        case chatMessage = "chat_message"
        case clearChat = "clear_chat"
        case dateTime = "date_time"
        case id = "id"
        case receiverDetail = "receiver_detail"
        case receiverId = "receiver_id"
        case requestId = "request_id"
        case result = "result"
        case senderDetail = "sender_detail"
        case senderId = "sender_id"
        case status = "status"
        case timezone = "timezone"
        case type = "type"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        chatImage = try values.decodeIfPresent(String.self, forKey: .chatImage)
        chatMessage = try values.decodeIfPresent(String.self, forKey: .chatMessage)
        clearChat = try values.decodeIfPresent(String.self, forKey: .clearChat)
        dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        receiverDetail = try values.decodeIfPresent(ResReceiverDetail.self, forKey: .receiverDetail)
        receiverId = try values.decodeIfPresent(String.self, forKey: .receiverId)
        requestId = try values.decodeIfPresent(String.self, forKey: .requestId)
        result = try values.decodeIfPresent(String.self, forKey: .result)
        senderDetail = try values.decodeIfPresent(ResSenderDetail.self, forKey: .senderDetail)
        senderId = try values.decodeIfPresent(String.self, forKey: .senderId)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }
    
}

struct ResSenderDetail : Codable {
    
    let address : String?
    let availableStatus : String?
    let categoryId : String?
    let cityId : String?
    let code : String?
    let countryId : String?
    let dateTime : String?
    let email : String?
    let expDate : String?
    let firstName : String?
    let id : String?
    let image : String?
    let iosRegisterId : String?
    let lastName : String?
    let lat : String?
    let licenceImage : String?
    let lon : String?
    let mobile : String?
    let password : String?
    let planId : String?
    let registerId : String?
    let registrationImage : String?
    let registrationNo : String?
    let senderImage : String?
    let socialId : String?
    let stateId : String?
    let status : String?
    let totalDeliveries : String?
    let type : String?
    let username : String?
    let vehicleId : String?
    let vehicleImage : String?
    let vehicleInsuraImage : String?
    let wallet : String?
    
    enum CodingKeys: String, CodingKey {
        case address = "address"
        case availableStatus = "available_status"
        case categoryId = "category_id"
        case cityId = "city_id"
        case code = "code"
        case countryId = "country_id"
        case dateTime = "date_time"
        case email = "email"
        case expDate = "exp_date"
        case firstName = "first_name"
        case id = "id"
        case image = "image"
        case iosRegisterId = "ios_register_id"
        case lastName = "last_name"
        case lat = "lat"
        case licenceImage = "licence_image"
        case lon = "lon"
        case mobile = "mobile"
        case password = "password"
        case planId = "plan_id"
        case registerId = "register_id"
        case registrationImage = "registration_image"
        case registrationNo = "registration_no"
        case senderImage = "sender_image"
        case socialId = "social_id"
        case stateId = "state_id"
        case status = "status"
        case totalDeliveries = "total_deliveries"
        case type = "type"
        case username = "username"
        case vehicleId = "vehicle_id"
        case vehicleImage = "vehicle_image"
        case vehicleInsuraImage = "vehicle_insura_image"
        case wallet = "wallet"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        availableStatus = try values.decodeIfPresent(String.self, forKey: .availableStatus)
        categoryId = try values.decodeIfPresent(String.self, forKey: .categoryId)
        cityId = try values.decodeIfPresent(String.self, forKey: .cityId)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        countryId = try values.decodeIfPresent(String.self, forKey: .countryId)
        dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        expDate = try values.decodeIfPresent(String.self, forKey: .expDate)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        iosRegisterId = try values.decodeIfPresent(String.self, forKey: .iosRegisterId)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        licenceImage = try values.decodeIfPresent(String.self, forKey: .licenceImage)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        planId = try values.decodeIfPresent(String.self, forKey: .planId)
        registerId = try values.decodeIfPresent(String.self, forKey: .registerId)
        registrationImage = try values.decodeIfPresent(String.self, forKey: .registrationImage)
        registrationNo = try values.decodeIfPresent(String.self, forKey: .registrationNo)
        senderImage = try values.decodeIfPresent(String.self, forKey: .senderImage)
        socialId = try values.decodeIfPresent(String.self, forKey: .socialId)
        stateId = try values.decodeIfPresent(String.self, forKey: .stateId)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        totalDeliveries = try values.decodeIfPresent(String.self, forKey: .totalDeliveries)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        vehicleId = try values.decodeIfPresent(String.self, forKey: .vehicleId)
        vehicleImage = try values.decodeIfPresent(String.self, forKey: .vehicleImage)
        vehicleInsuraImage = try values.decodeIfPresent(String.self, forKey: .vehicleInsuraImage)
        wallet = try values.decodeIfPresent(String.self, forKey: .wallet)
    }
}

struct ResReceiverDetail : Codable {
    
    let address : String?
    let availableStatus : String?
    let categoryId : String?
    let cityId : String?
    let code : String?
    let countryId : String?
    let dateTime : String?
    let email : String?
    let expDate : String?
    let firstName : String?
    let id : String?
    let image : String?
    let iosRegisterId : String?
    let lastName : String?
    let lat : String?
    let licenceImage : String?
    let lon : String?
    let mobile : String?
    let password : String?
    let planId : String?
    let receiverImage : String?
    let registerId : String?
    let registrationImage : String?
    let registrationNo : String?
    let socialId : String?
    let stateId : String?
    let status : String?
    let totalDeliveries : String?
    let type : String?
    let username : String?
    let vehicleId : String?
    let vehicleImage : String?
    let vehicleInsuraImage : String?
    let wallet : String?
    
    enum CodingKeys: String, CodingKey {
        case address = "address"
        case availableStatus = "available_status"
        case categoryId = "category_id"
        case cityId = "city_id"
        case code = "code"
        case countryId = "country_id"
        case dateTime = "date_time"
        case email = "email"
        case expDate = "exp_date"
        case firstName = "first_name"
        case id = "id"
        case image = "image"
        case iosRegisterId = "ios_register_id"
        case lastName = "last_name"
        case lat = "lat"
        case licenceImage = "licence_image"
        case lon = "lon"
        case mobile = "mobile"
        case password = "password"
        case planId = "plan_id"
        case receiverImage = "receiver_image"
        case registerId = "register_id"
        case registrationImage = "registration_image"
        case registrationNo = "registration_no"
        case socialId = "social_id"
        case stateId = "state_id"
        case status = "status"
        case totalDeliveries = "total_deliveries"
        case type = "type"
        case username = "username"
        case vehicleId = "vehicle_id"
        case vehicleImage = "vehicle_image"
        case vehicleInsuraImage = "vehicle_insura_image"
        case wallet = "wallet"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        availableStatus = try values.decodeIfPresent(String.self, forKey: .availableStatus)
        categoryId = try values.decodeIfPresent(String.self, forKey: .categoryId)
        cityId = try values.decodeIfPresent(String.self, forKey: .cityId)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        countryId = try values.decodeIfPresent(String.self, forKey: .countryId)
        dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        expDate = try values.decodeIfPresent(String.self, forKey: .expDate)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        iosRegisterId = try values.decodeIfPresent(String.self, forKey: .iosRegisterId)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        licenceImage = try values.decodeIfPresent(String.self, forKey: .licenceImage)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        planId = try values.decodeIfPresent(String.self, forKey: .planId)
        receiverImage = try values.decodeIfPresent(String.self, forKey: .receiverImage)
        registerId = try values.decodeIfPresent(String.self, forKey: .registerId)
        registrationImage = try values.decodeIfPresent(String.self, forKey: .registrationImage)
        registrationNo = try values.decodeIfPresent(String.self, forKey: .registrationNo)
        socialId = try values.decodeIfPresent(String.self, forKey: .socialId)
        stateId = try values.decodeIfPresent(String.self, forKey: .stateId)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        totalDeliveries = try values.decodeIfPresent(String.self, forKey: .totalDeliveries)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        vehicleId = try values.decodeIfPresent(String.self, forKey: .vehicleId)
        vehicleImage = try values.decodeIfPresent(String.self, forKey: .vehicleImage)
        vehicleInsuraImage = try values.decodeIfPresent(String.self, forKey: .vehicleInsuraImage)
        wallet = try values.decodeIfPresent(String.self, forKey: .wallet)
    }
}
