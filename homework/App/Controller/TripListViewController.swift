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
    
    let driverDataService: DriverDataServiceClient
    let userService: UserServiceClient
    var tripsData: [TripModel] = []
    
    init(userService: UserServiceClient = UserService(), driverDataService: DriverDataServiceClient = DriverDataService()) {
        self.userService = userService
        self.driverDataService = driverDataService
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
        tripsData = tripsData.sorted(by: { $0.id ?? "" > $1.id ?? "" })
        tableView.reloadData()
    }
    
    @objc private func refreshData() {
        userService.token { (newToken) in
            guard let t = newToken else {
                print("No new token")
                return
            }
            self.driverDataService.setTokenToUserDefaults(token: t)
            self.driverDataService.fetchDriverData(token: t) { (success) in
                switch success {
                case true:
                    self.retrieveTripData()
                case false:
                    print("couldn't fetch new driver data")
                }
            }
        }
    }
    
    func retrieveTripData() {
        guard let trips = CoreDataHelper.arrayOf(TripModel.self) as? [TripModel] else { return }
        tripsData = trips
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension TripListViewController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.83, green: 0.77, blue: 0.98, alpha: 1.00)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 380, height: 60))
        label.text = "Tap the cell to view distance from delivery location."
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.textAlignment = .center
        view.addSubview(label)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripsData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let trip = tripsData[indexPath.row]
        guard let tripId = trip.id else {
            cell.textLabel?.text = "No trip data available"
            return cell
        }
        guard let distance = trip.truckingOrder?.tripDistanceMiles else {
            cell.textLabel?.text = "Trip: \(tripId)  " + "   Distance: \("n/a")"
            return cell
        }
        cell.textLabel?.text = "Trip: \(tripId)  " + "   Distance: \(distance)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mapViewController = MapViewController()
        mapViewController.tripTruckingOrder = self.tripsData[indexPath.row].truckingOrder
        self.navigationController?.present(MapViewController(), animated: true, completion: nil)
    }
}
