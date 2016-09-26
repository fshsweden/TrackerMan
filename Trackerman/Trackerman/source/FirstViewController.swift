//
//  FirstViewController.swift
//  Trackerman
//
//  Created by Peter Andersson on 31/07/16.
//  Copyright © 2016 Peter Andersson. All rights reserved.
//

import UIKit
import MapKit

class FirstViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var myLocation: UILabel!
    
    var uuid : NSString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Setting up first view!")

        // 4) Set location of the map: Fuengirola - Malaga 36.5417° N, 4.6250° W
        // FirstViewController.setMapLocation(mapView: mapView, latitude: 36.548628, longitud: -4.6307649)
     
        let uuid = UserDefaults.standard.value(forKey: "ApplicationIdentifier")!
        
        // startLocationServices()
        // createPlayer()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    static func setMapLocation(mapView: MKMapView, latitude: CLLocationDegrees, longitud: CLLocationDegrees, zoom: Double = 1){
        
        // define the map zoom span
        let latitudZoomLevel : CLLocationDegrees = zoom
        let longitudZoomLevel : CLLocationDegrees = zoom
        let zoomSpan:MKCoordinateSpan = MKCoordinateSpanMake(latitudZoomLevel, longitudZoomLevel)
        
        // use latitud and longitud to create a location coordinate
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitud)
        
        // define and set the region of our map using the zoom map and location
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, zoomSpan)
        mapView.setRegion(region, animated: true)
        
    }
    
    
    func startLocationServices() {
        
        print("Starting LOCATION Services...")
        
        let locationManager = LocationManager.sharedInstance
        locationManager.showVerboseMessage = true
        locationManager.autoUpdate = false
        
        locationManager.startUpdatingLocationWithCompletionHandler { (latitude, longitude, status, verboseMessage, error) -> () in
            print("Callback: lat:\(latitude) lon:\(longitude) status:\(status) error:\(error)")
            print(verboseMessage)
        }
    }
    
    
    func createPlayer() {
        // RestApiClient.sharedInstance.testIt()
    }
    
}

