//
//  DemoAuth.swift
//  homework
//
//  Created by Alex Rouse on 4/7/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation
import Auth0

extension DemoAuthClient {

    var clientId: String    { return "za6TP5NcPzU4RS7ioSVM4O51aDl1y0Oy" }
    var domain: String      { return "indigoag-staging.auth0.com" }
    var scopes: String      { return "offline_access" }
    var realm: String       { return "Username-Password-Authentication" }

    var username: String    { return "evaluations+ios@indigoag.org" }
    var password: String    { return "qarTun-wibkyj-ryzvu0" }

    var audience: String    { return "https://\(domain)/userinfo" }

    func login(email: String, password: String, then completion: @escaping (String?) -> Void) {

        Auth0.authentication(clientId: clientId, domain: domain).login(usernameOrEmail: email,
                             password: password,
                             realm: realm,
                             audience: audience,
                             scope: scopes,
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

extension DemoAuthClient {

    func token(then completion: @escaping (String?) -> Void) {
        login(email: username, password: password, then: completion)
    }
}
