//
//  TripResponseTests.swift
//  homework
//
//  Created by Naomi Schettini on 5/15/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation
import XCTest
@testable import homework

class UserServiceTests: XCTestCase {
    
    var loginVC: LoginViewController!
    var userService: UserServiceClient!
    var driverDataService: DriverDataServiceClient!
    
    override func setUp() {
        self.userService = UserService()
        self.driverDataService = DriverDataService()
        self.loginVC = LoginViewController(userService: userService, driverDataService: driverDataService)
    }
    /* Cannot import Auth0 for some reason and I think that's why tests don't build. However, here are two hypothetical example tests. **/
    func testUserLoginFail() {
        let email = "aaa@fnf.hu"
        let password = "fodkf"
        userService.login(email: email, password: password) { (response) in
            guard let resp = response else { return }
            print(resp)
            XCTAssertNil(resp)
        }
    }
    
    func testUserLoginSucceed() {
        let email = Constants.Login.username
        let password = Constants.Login.password
        userService.login(email: email, password: password) { (response) in
            guard let resp = response else { return }
            print(resp)
            XCTAssertNil(resp)
        }
    }
}
