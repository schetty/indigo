//
//  LoginView.swift
//  homework
//
//  Created by Naomi Schettini on 5/15/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 30,
                              y: 300,
                              width: 350,
                              height: 50)
        button.backgroundColor = .black
        button.setTitle("Login as evaluations+ios@indigoag.org", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    lazy var seeTripsButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 30,
                              y: 380,
                              width: 350,
                              height: 50)
        button.backgroundColor = .black
        button.alpha = 0.5
        button.isEnabled = false
        button.setTitle("See Trips", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setup() {
        self.backgroundColor = .white
        addSubview(loginButton)
        addSubview(seeTripsButton)
    }
}
