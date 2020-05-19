//
//  MapListViewController.swift
//  homework
//
//  Created by Naomi Schettini on 5/15/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation
import UIKit

class LoadListViewController: UITableViewController {
    
    let service: DriverDataServiceClient
    var loadsData: [Load] = []
    
    init(service: DriverDataServiceClient = DriverDataService()) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .magenta
    }
    
    func refreshToken() {
    }
    
    private func fetchDriverData() {
        guard let token = PersistencyManager.sharedManager.fetchDriver()?.token else { return }
        service.fetchDriverData(token: token) { ()  in
            guard let loads = driver.loads else { return }
            print(loads)
            self.loadsData = loads
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension LoadListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadsData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Hello World"
        return cell
    }
}
