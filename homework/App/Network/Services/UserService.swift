//
//  UserService.swift
//  homework
//
//  Created by Naomi Schettini on 5/15/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation
import Auth0
import UIKit

protocol UserServiceClient {
    func token(then completion: @escaping (String?) -> Void)
}

class UserService: UserServiceClient {
    
    var tokenSet: Bool = false
    
    func login(email: String, password: String, then completion: @escaping (String?) -> Void) {
        Auth0.authentication(clientId: Constants.Login.clientId, domain: Constants.Login.domain).login(
                             usernameOrEmail: Constants.Login.username,
                             password: Constants.Login.password,
                             realm: Constants.Login.realm,
                             audience: Constants.Login.audience,
                             scope: Constants.Login.scopes,
                             parameters: nil).start { result in
                             switch result {
                             case .failure(let error):
                              print("Error authenticating.  Contact Indigo, this shouldn't happen: \(error)")
                              completion(nil)
                              case .success(let creds):
                              completion(creds.idToken)
            }
        }
    }
}

extension UserService {
    func token(then completion: @escaping (String?) -> Void) {
        login(email: Constants.Login.username, password: Constants.Login.password, then: completion)
    }
}

