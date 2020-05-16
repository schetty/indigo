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
    case fetchDriverData

    var baseURL: URL {
        switch self {
        case .fetchDriverData:
            return Constants.apiURL
        }
    }
}

protocol DriverDataServiceClient {
    func fetchDriverData(token: String, _ completionHandler: @escaping (Driver, Error?) -> () )
}

class DriverDataService: DriverDataServiceClient {
    func fetchDriverData(token: String, _ completionHandler: @escaping (_ driver: Driver, Error?) -> () ) {
        //TODO: Handle URLSession task here.

        let session = URLSession.shared
        var request = URLRequest(url: Constants.apiURL)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                 let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(Driver.self, from: data)
                print(response)

            } catch {
                print(error)
            }
        })
        task.resume()
        completionHandler(Driver(), nil)
    }
}
