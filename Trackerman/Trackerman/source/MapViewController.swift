//
//  MapViewController.swift
//  Videotest
//
//  Created by Peter Andersson on 24/08/16.
//  Copyright © 2016 Peter Andersson. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class MapviewController : UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var mapView: MKMapView!
    var locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 1000
    
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(
            location.coordinate,
            regionRadius * 2.0,
            regionRadius * 2.0
        )
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        
        // set initial location in Honolulu
        // let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        // centerMapOnLocation(initialLocation)
        
    }
    
    @IBAction func locateMe(_ sender: UIBarButtonItem) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation:CLLocation = locations[0] as CLLocation
        
        let coordinations = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,longitude: userLocation.coordinate.longitude)
        
        let span = MKCoordinateSpanMake(0.2,0.2)
        let region = MKCoordinateRegion(center: coordinations, span: span)//this basically tells your map where to look and where from what distance
        
        mapView.setRegion(region, animated: true)
    }
}

