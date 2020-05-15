//
//  MapView.swift
//  homework
//
//  Created by Naomi Schettini on 5/15/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation
import UIKit

class MapView: UIView {
    
    let tv = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTV()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupTV()
    }
    
    private func setupTV() {
        addSubview(tv)
        tv.frame = self.frame
        tv.backgroundColor = .lightGray
    }
}
