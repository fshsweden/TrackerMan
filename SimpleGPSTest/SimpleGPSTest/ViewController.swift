//
//  ViewController.swift
//  SimpleGPSTest
//
//  Created by Peter Andersson on 02/08/16.
//  Copyright © 2016 Peter Andersson. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    
    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation! // implicitly unwrapped Optional!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        startLocation = nil
        
        addDummyData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
//    Implementing the Application Delegate Methods
//    When the location manager detects a location change, it calls the  
//    didUpdateToLocation delegate method. Since the view conroller was declared as
//    the delegate for the location manager in the viewDidLoad method, it is 
//    necessary to now implement this method in the ViewController.swift file:
    
    func locationManager(manager: CLLocationManager,  didUpdateLocations locations: [CLLocation])
    {
        print ("didUpdateLocations!")
        
        latitude.text = "HEJ"
        
        let latestLocation: AnyObject = locations[locations.count - 1]
        
        latitude.text = String(format: "%.4f",   latestLocation.coordinate.latitude)
        longitude.text = String(format: "%.4f",  latestLocation.coordinate.longitude)
        // horizontalAccuracy.text = String(format: "%.4f",  latestLocation.horizontalAccuracy)
        // altitude.text = String(format: "%.4f",   latestLocation.altitude)
        // verticalAccuracy.text = String(format: "%.4f",    latestLocation.verticalAccuracy)
        
        if startLocation == nil {
            startLocation = latestLocation as! CLLocation
        }
        
        // var distanceBetween: CLLocationDistance =
        // latestLocation.distanceFromLocation(startLocation)
        
        // distance.text = String(format: "%.2f", distanceBetween)
    }

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
    }
    
    func addDummyData() {
        
        RestApiManager.sharedInstance.getRandomUser { json in
            let results = json["results"]
            
            for (index, subJson) in results {
                
                print("INDEX: " + "\(index)" + " " + "\(subJson)");
                // let user: AnyObject = subJson["user"].object
               
                /* self.items.addObject(user)
                dispatch_async(dispatch_get_main_queue(),{
                    tableView?.reloadData()
                }) */
            }
        }
    }
}

