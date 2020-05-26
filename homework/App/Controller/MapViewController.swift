//
//  MapViewController.swift
//  homework
//
//  Created by Naomi Schettini on 5/25/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    fileprivate let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        return manager
    }()
    @IBOutlet weak var mapView: MKMapView!
    public var tripTruckingOrder: TruckingOrderModel?
    
    
    override func viewDidLoad() {
        // mapView.centerToLocation(initialLocation)
        setUpMapView()
        markOrderDestinationLocation()
    }
    
    private func setUpMapView() {
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.delegate = self
        currentLocation()
    }
    
    private func currentLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 11.0, *) {
            locationManager.showsBackgroundLocationIndicator = true
        } else {
        }
        locationManager.startUpdatingLocation()
    }
    
    private func markOrderDestinationLocation() {
        guard let lat = tripTruckingOrder?.locationTo?.coordinates?.latitude, let long = tripTruckingOrder?.locationTo?.coordinates?.latitude, let currentLoc: CLLocationCoordinate2D = locationManager.location?.coordinate else {
            print("No coordinates")
            return
        }
        let deliveryLoc = CLLocationCoordinate2D(latitude: lat, longitude: long)
        addAnnotations(coords2d: [currentLoc, deliveryLoc])
    }
    
    private func addAnnotations(coords2d: [CLLocationCoordinate2D]) {
        for coord in coords2d {
            let anno = MKPointAnnotation()
            anno.coordinate = coord
            mapView.addAnnotation(anno)
        }
        mapView.fitAll()
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last! as CLLocation
        let currentLocation = location.coordinate
        let coordinateRegion = MKCoordinateRegion(center: currentLocation, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(coordinateRegion, animated: true)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

extension MKMapView {

    func fitAll() {
        var zoomRect            = MKMapRect.null;
        for annotation in annotations {
            let annotationPoint = MKMapPoint(annotation.coordinate)
            let pointRect       = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0.01, height: 0.01);
            zoomRect            = zoomRect.union(pointRect);
        }
        setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
    }

    /// we call this function and give it the annotations we want added to the map. we display the annotations if necessary
    func fitAll(in annotations: [MKAnnotation], andShow show: Bool) {
        var zoomRect:MKMapRect  = MKMapRect.null

        for annotation in annotations {
            let aPoint          = MKMapPoint(annotation.coordinate)
            let rect            = MKMapRect(x: aPoint.x, y: aPoint.y, width: 0.1, height: 0.1)

            if zoomRect.isNull {
                zoomRect = rect
            } else {
                zoomRect = zoomRect.union(rect)
            }
        }
        if(show) {
            addAnnotations(annotations)
        }
        setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
    }

}
