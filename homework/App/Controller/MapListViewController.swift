//
//  MapListViewController.swift
//  homework
//
//  Created by Naomi Schettini on 5/15/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation
import UIKit

class MapListViewController: UITableViewController {

    let service: MapServiceClient
    var mapData: [MapModel] = []
    
    init(service: MapServiceClient = MapService()) {
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
    
    private func fetchMapData() {
        service.fetchPOI { (model, e) in
            if let e = e {
                
            }
            else {
                self.mapData = model
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension MapListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return mapData.count
        return 8
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: Need to setup tableviewcell here. Make it how you want
        let cell = UITableViewCell()
        cell.textLabel?.text = "Hello World"
        return cell
    }
}
