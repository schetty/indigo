//
//  MapListViewController.swift
//  homework
//
//  Created by Naomi Schettini on 5/15/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class LoadListViewController: UITableViewController {
    
    let service: DriverDataServiceClient
    
    var tripsData: [Trip] = []
    
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
    
    func retrieveTripData() {
        let request: NSFetchRequest<Trip> = Trip.fetchRequest()
        let sort = NSSortDescriptor(key: "id", ascending: false)
        request.resultType = .managedObjectResultType
        do {
            self.tripsData = try CoreDataHelper.sharedInstance.getContext().fetch(request)
            tableView.reloadData()
        } catch {
            print("Fetch failed")
        }
    }
}

extension LoadListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripsData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let load = tripsData[indexPath.row]
        guard let id = tripsData[indexPath.row].id else {
            cell.textLabel?.text = "No trip data available"
            return cell
        }
        cell.textLabel?.text = id
        return cell
    }
}
