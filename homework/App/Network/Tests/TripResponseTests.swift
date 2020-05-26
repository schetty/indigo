//
//  TripResponseTests.swift
//  homework
//
//  Created by Naomi Schettini on 5/15/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation
import XCTest
@testable import Auth0
@testable import homework

class UserServiceTests: XCTestCase {
    
    var loginVC = LoginViewController!
    var userServiceClient: UserServiceClient!
    var driverDataServiceClient: DriverDataServiceClient!
    
    override func setUp() {
        loginVC = LoginViewController(userServiceClient: UserService(), driverDataServiceClient: driverDataService())
    }
    
    func testUserLoginFail() {
        let email = "aaa@fnf.hu"
        let password = "fodkf"
    }
    
    func testUserLoginSucceed() {
        
    }
}
