//
//  LoginViewController.swift
//  homework
//
//  Created by Naomi Schettini on 5/15/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation
import UIKit
import CoreData

enum UserStatus {
    case loggedIn
    case loggedOut
}

class LoginViewController: UIViewController {
    
    struct StringConstants {
        static let loginAs = "Login as evaluations+ios@indigoag.org"
        static let loggedIn = "logged in :)"
    }
    private let rootView = LoginView()
    private let userService: UserServiceClient
    private let helper = CoreDataHelper.sharedInstance
    private let driverDataService: DriverDataServiceClient
    
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
        adjustUIForStatus()
    }
    
    @objc func loginUser() {
        let email = Constants.Login.username
        let password = Constants.Login.password
        userService.login(email: email, password: password, then: { (response) in
            guard let token = response else { return print("error") }
            UserDefaults.standard.set(token, forKey: "token")
            DispatchQueue.main.async {
                self.adjustUIForStatus()
            }
        })
    }
    
    private func hasToken() -> Bool {
        if (UserDefaults.standard.string(forKey: "token") != nil) { return true }
        return false
    }
    
    @objc func presentList() {
        guard hasToken(), let tok = UserDefaults.standard.string(forKey: "token") else { return }
        driverDataService.fetchDriverData(token: tok) { success in
            if success {
                DispatchQueue.main.async {
                    self.presentListVC()
                }
            }
        }
    }
    
    private func presentListVC() {
        let list = TripListViewController()
        let navigationController = UINavigationController(rootViewController: list)
        self.present(navigationController, animated: true, completion: nil)
    }
}

extension LoginViewController {
    
    func adjustUIForStatus() {
        if hasToken() {
            DispatchQueue.main.async {
                self.rootView.loginButton.setTitle(StringConstants.loggedIn, for: .normal)
                self.rootView.seeTripsButton.isEnabled = true
                self.rootView.seeTripsButton.alpha = 1.0
            }
        } else {
            DispatchQueue.main.async {
                self.rootView.loginButton.setTitle(StringConstants.loginAs, for: .normal)
                self.rootView.seeTripsButton.isEnabled = false
                self.rootView.seeTripsButton.alpha = 0.5
            }
        }
    }
}

