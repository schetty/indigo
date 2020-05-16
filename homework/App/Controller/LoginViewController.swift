//
//  LoginViewController.swift
//  homework
//
//  Created by Naomi Schettini on 5/15/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation
import UIKit

enum Status {
    case loggedIn
    case loggedOut
}

class LoginViewController: UIViewController {
    
    let rootView = LoginView()
    let service: UserServiceClient
    let auth: Auth
    var status: Status = .loggedOut

    init(service: UserServiceClient = UserService(), authClient: Auth = DemoAuthClient()) {
        self.service = service
        self.auth = authClient
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
        PersistencyManager.sharedManager.persistentContainer.viewContext
        rootView.loginButton.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
        rootView.seeTripsButton.addTarget(self, action: #selector(presentList), for: .touchUpInside)
    }
    
    @objc func loginUser() {
        service.login(email: Constants.Login.username, password: Constants.Login.password, then: { (response) in
            guard let token = response else { return print("error") }
            PersistencyManager.sharedManager.buildDriver(token: token)
            self.status = .loggedIn
            self.adjustStatus()
        })
    }
    
    @objc func presentList() {
        let list = LoadListViewController()
        self.present(list, animated:true, completion:nil)
    }
}

extension LoginViewController {
    
    func adjustStatus() {
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

