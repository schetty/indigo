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
    func fetchDriverData(token: String, _ completionHandler: @escaping (_ success: Bool) -> () )
}

extension DriverDataServiceClient {
    func setTokenToUserDefaults(token: String) {}
    func getToken() -> String? { return nil }
}

class DriverDataService: DriverDataServiceClient {
    
    func setTokenToUserDefaults(token: String) {
        UserDefaults.standard.set(token, forKey: "token")
    }
    
    func getToken() -> String? {
        guard let t = UserDefaults.standard.string(forKey: "token") else { return nil }
        return t
    }
    
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
    
    func fetchDriverData(token: String, _ completionHandler: @escaping (_ success: Bool) -> () ) {
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
                let context = CoreDataHelper.sharedInstance.persistentContainer.newBackgroundContext()
                let decoder = JSONDecoder(context: context)
                let resp = try decoder.decode(ResponseModel.self, from: data)
                if (resp.data != nil) {
                   print("success")
                   try context.save()
                }
                completionHandler(true)
            } catch {
                print(error)
                completionHandler(false)
            }
        })
        task.resume()
    }
}
