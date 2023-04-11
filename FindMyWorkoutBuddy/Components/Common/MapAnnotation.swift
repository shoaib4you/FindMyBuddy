//
//  MapAnnotation.swift
//  VanbuDriver
//
//  Created by mac on 14/07/21.
//
import UIKit
import MapKit

class MapAnnotation: NSObject, MKAnnotation {
    /*
     Using dynamic tells Swift to always refer to Objective-C dynamic dispatch.
     This is required for things like Key-Value Observing to work correctly.
     When the Swift function is called, it refers to the Objective-C runtime to dynamically dispatch the call.
     stackoverflow link: https://stackoverflow.com/questions/40795840/swift-3-dynamic-vs-objc
    */
    dynamic var coordinate: CLLocationCoordinate2D
    dynamic var title: String?
    dynamic var subtitle: String?
    var isDriver: Bool = false
    var imageName: String!
    var point:String!
    var tagg:Int!

    init(coordinate: CLLocationCoordinate2D, title: String? = nil, subtitle: String? = nil, tag: Int? = nil) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.tagg = tag
        super.init()
    }
}
