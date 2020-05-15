//
//  AuthService.swift
//  homework
//
//  Created by Alex Rouse on 4/7/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation

protocol Auth {

    /// Gets back an auth token for connecting to the service
    /// This token should then be set as the authorization header on requests to the apiURL endpoint, as outlined in the README
    /// - Parameter completion: Callback with the active token
    func token(then completion: @escaping (String?) -> Void)
}

class DemoAuthClient: Auth { }

