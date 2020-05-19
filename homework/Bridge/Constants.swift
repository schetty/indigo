//
//  Constants.swift
//  homework
//
//  Created by Alex Rouse on 4/7/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation

struct Constants {

    static var apiURL = URL(string: "https://api.indigoag.build/graphql")!
    static var requestBodyJson = "request_body"

    
    struct Login {
        static var clientId: String    { return "za6TP5NcPzU4RS7ioSVM4O51aDl1y0Oy" }
        static var domain: String      { return "indigoag-staging.auth0.com" }
        static var scopes: String      { return "offline_access" }
        static var realm: String       { return "Username-Password-Authentication" }
        static var username: String    { return "evaluations+ios@indigoag.org" }
        static var password: String    { return "qarTun-wibkyj-ryzvu0" }
        static var audience: String    { return "https://\(domain)/userinfo" }
    }
    
}
