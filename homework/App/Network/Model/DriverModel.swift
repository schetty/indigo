//
//  Loads.swift
//  homework
//
//  Created by Naomi Schettini on 5/15/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation

class User: Codable {
    var token: String?
}

class Driver: User {
    var loads: [Load]?
}

class Load: Codable {
    var trips: [Trip]?
}

class Trip: Codable {
    let id, progress: String
    var truckingOrder: TruckingOrder?
}

class TruckingOrder: Codable {
    let id: String
    var tripDistanceMiles: Int
    var orderType: String
    var locationFrom: Coordinate?
    var locationTo: Coordinate?
}

class Coordinate: Codable {
    var latitude: Double
    var longitude: Double
}
