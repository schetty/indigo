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

class TripListViewController: UITableViewController {
    
    let service: DriverDataServiceClient
    var tripsData: [TripModel] = []
    
    init(service: DriverDataServiceClient = DriverDataService()) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBarButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        retrieveTripData()
        tableView.reloadData()
    }
    
    private func addBarButtons() {
        let sort = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortByID))
        let refresh = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refreshData))
        self.navigationItem.rightBarButtonItems = [sort, refresh]
    }
    
    @objc private func sortByID() {
        tableView.reloadData()
    }
    
    @objc private func refreshData() {
        tableView.reloadData()
    }
    
    func retrieveTripData() {
        let context = CoreDataHelper.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TripModel")
        do {
//            let resp = try context.fetch(fetchRequest)
            let response = TripModel(context: context)
            tripsData.append(response)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}

extension TripListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripsData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let trip = tripsData[indexPath.row]
        guard let progress = trip.progress else {
            cell.textLabel?.text = "No trip data available"
            return cell
        }
        cell.textLabel?.text = progress
        return cell
    }
    
}
