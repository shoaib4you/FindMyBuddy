//
//  Variables.swift
//  Boom
//
//  Created by mac on 05/12/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit


var globalUserName          =       k.userDefault.value(forKey: "user_name")
var globalUserImage         =       k.userDefault.value(forKey: "user_image")

enum emDays: Int {
    case monday = 1
    case tuesday = 2
    case wednesday = 3
    case thursday = 4
    case friday = 5
    case saturday = 6
    case sunday = 7
    
    func rawStatus() -> String {
        switch self {
        case .monday:
            return "monday"
        case .tuesday:
            return "tuesday"
        case .wednesday:
            return "wednesday"
        case .thursday:
            return "thursday"
        case .friday:
            return "friday"
        case .saturday:
            return "saturday"
        case .sunday:
            return "sunday"
        }
    }
}

var arrTiming = [
    "00:00-01:00",
    "01:00-02:00",
    "03:00-04:00",
    "04:00-05:00",
    "05:00-06:00",
    "06:00-07:00",
    "07:00-08:00",
    "08:00-09:00",
    "09:00-10:00",
    "10:00-11:00",
    "11:00-12:00",
    "12:00-13:00",
    "13:00-14:00",
    "14:00-15:00",
    "15:00-16:00",
    "16:00-17:00",
    "17:00-18:00",
    "18:00-19:00",
    "19:00-20:00",
    "20:00-21:00",
    "21:00-22:00",
    "22:00-23:00",
    "23:00-00:00"
]

var CURRENT_TIME: String {
    get {
        return Date().description(with: Locale.current)
    }
}

var localTimeZoneIdentifier: String { return TimeZone.current.identifier }

enum emLang: String {
    case english
    case german
    case french
    case spanish
    case russian
    case korean
    case italian
    case portugese
    case chinese
    case japanese
}
var cLang: emLang = .english
var dictSignup:[String:String] = [:]

var globalDeliveryOption = ""
