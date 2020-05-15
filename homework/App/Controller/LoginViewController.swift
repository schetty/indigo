//
//  LoginViewController.swift
//  homework
//
//  Created by Naomi Schettini on 5/15/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    let rootView = LoginView()
    let service: UserServiceClient
    
    init(service: UserServiceClient = UserService()) {
        self.service = service
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
        rootView.submitButton.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
    }
    
    @objc func loginUser() {
        service.loginUser { (e) in
            if let e = e {
                //handle errora
                print("error here,", e)
            }
            else {
                let map = MapListViewController()
                self.present(map, animated:true, completion:nil)
            }
        }
    }
}
