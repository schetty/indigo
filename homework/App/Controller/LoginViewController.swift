//
//  LoginViewController.swift
//  homework
//
//  Created by Naomi Schettini on 5/15/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation
import UIKit

enum UserStatus {
    case loggedIn
    case loggedOut
}

class LoginViewController: UIViewController {
    
    let rootView = LoginView()
    let userService: UserServiceClient
    let driverDataService: DriverDataServiceClient
    var status: UserStatus = .loggedOut
    
    init(userService: UserServiceClient = UserService(), driverDataService: DriverDataServiceClient = DriverDataService()) {
        self.userService = userService
        self.driverDataService = driverDataService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.loginButton.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
        rootView.seeTripsButton.addTarget(self, action: #selector(presentList), for: .touchUpInside)
        guard let driver = PersistencyManager.sharedManager.fetchDriver(), driver.token != nil else { self.status = .loggedOut
            return
        }
        self.status = .loggedIn
        adjustUIForStatus()
    }
    
    @objc func loginUser() {
        userService.login(email: Constants.Login.username, password: Constants.Login.password, then: { (response) in
            guard let token = response else { return print("error") }
            PersistencyManager.sharedManager.buildDriver(token: token)
            self.status = .loggedIn
            self.adjustUIForStatus()
        })
    }
    
    @objc func presentList() {
        guard let driver = PersistencyManager.sharedManager.fetchDriver(), let token = driver.token else { print("Cannot fetch token from driver")
            return
        }
        driverDataService.fetchDriverData(token: token) { () in
        }
        let list = LoadListViewController()
        self.present(list, animated:true, completion:nil)
    }
}

extension LoginViewController {
    
    func adjustUIForStatus() {
        if status == .loggedIn {
            DispatchQueue.main.async {
                self.rootView.loginButton.setTitle("logged in :)", for: .normal)
                self.rootView.seeTripsButton.isEnabled = true
                self.rootView.seeTripsButton.alpha = 1.0
            }
        } else {
            DispatchQueue.main.async {
                self.rootView.loginButton.setTitle("Login as evaluations+ios@indigoag.org", for: .normal)
                self.rootView.seeTripsButton.isEnabled = false
                self.rootView.seeTripsButton.alpha = 0.5
            }
        }
    }
}

