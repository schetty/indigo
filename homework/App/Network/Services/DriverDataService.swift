//
//  MapService.swift
//  homework
//
//  Created by Naomi Schettini on 5/15/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation
import UIKit

private enum Endpoint {
    case fetchDriverData
    
    var baseURL: URL {
        switch self {
        case .fetchDriverData:
            return Constants.apiURL
        }
    }
}

protocol DriverDataServiceClient {
    func fetchDriverData(token: String, _ completionHandler: @escaping () -> () )
}

class DriverDataService: DriverDataServiceClient {
    
    private var mockContentData: Data? {
        var data: Data? = nil
        if let url = Bundle.main.url(forResource: Constants.requestBodyJson, withExtension: "json") {
            do {
                let d = try Data(contentsOf: url)
                data = d
            } catch {
                print(error)
            }
        }
        return data
    }
    
    func fetchDriverData(token: String, _ completionHandler: @escaping () -> (Void) ) {
        let session = URLSession.shared
        var request = URLRequest(url: Endpoint.fetchDriverData.baseURL)
        request.addValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        guard let mockData = mockContentData else {
            print("Cannot send body")
            return
        }
        request.httpBody = mockData
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else {
                print("there was an error")
                return
            }
            guard let data = data else {
                print("there was a data error")
                return
            }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(DataJSON.self, from: data)
                print(response)
                
            } catch {
                print(error)
            }
        })
        task.resume()
        completionHandler()
    }
}

extension String {
    func convertToDictionary() -> [String: Any]? {
        if let data = data(using: .utf8) {
            return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        }
        return nil
    }
}

