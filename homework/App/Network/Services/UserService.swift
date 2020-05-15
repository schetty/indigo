//
//  UserService.swift
//  homework
//
//  Created by Naomi Schettini on 5/15/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation
import UIKit

protocol UserServiceClient {
    func loginUser(_ completionHandler: @escaping (Error?) -> ())
}

class UserService: UserServiceClient {
    
    func loginUser(_ completionHandler: @escaping (Error?) -> () ) {
        //TODO: Handle URLSession task here.
        completionHandler(nil)
    }
}
