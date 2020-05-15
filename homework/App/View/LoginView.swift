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
    
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 120,
                              y: 400,
                              width: 200,
                              height: 50)
        button.backgroundColor = .black
        button.setTitle("Show Map:)", for: .normal)
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
        self.backgroundColor = .cyan
        addSubview(submitButton)
    }
}
