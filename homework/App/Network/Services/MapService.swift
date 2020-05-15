//
//  MapService.swift
//  homework
//
//  Created by Naomi Schettini on 5/15/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation
import UIKit

//TODO: Need to setup the proper headers for URLSession task
enum Endpoint {
    case fetchPOI

    var baseURL: URL {
        switch self {
        case .fetchPOI:
            return Constants.apiURL
        }
    }
}

protocol MapServiceClient {
    func fetchPOI(_ completionHandler: @escaping ([MapModel], Error?) -> () )
}

class MapService: MapServiceClient {
    func fetchPOI(_ completionHandler: @escaping ([MapModel], Error?) -> () ) {
        //TODO: Handle URLSession task here.
        completionHandler([], nil)
    }
}
