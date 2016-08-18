//
//  SecondViewController.swift
//  Trackerman
//
//  Created by Peter Andersson on 31/07/16.
//  Copyright © 2016 Peter Andersson. All rights reserved.
//

import UIKit
import CoreLocation

public typealias Str2StrMap     = [String:String];
public typealias Str2AnyObjMap  = [String:AnyObject];
public typealias Str2Dict       = [String:Dictionary<String,String>];
public typealias Str2Dict2Dict  = [String:Dictionary<String,Dictionary<String,String>>];
public typealias Str2Str2StrMap = [String:Str2StrMap];

public class SecondViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var trackingButton: UIButton!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var horizAccuracy: UILabel!
    @IBOutlet weak var verticalAccuracy: UILabel!
    @IBOutlet weak var name: UITextField!
    
    var tracking : Bool = false
    
    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation! // implicitly unwrapped Optional!
    
    /*
     Structure - Dictionary <String -> Dictionary<String,String>>
     
        [player]        Key: String -> Value: Dictionary<String, Dictionary<String,String> >
            [info]      Key: String -> Value: Dictionary<String, String >
                name
                age
                etc
        [positions]     Key: String -> Value: Dictionary<String, Dictionary<String,String> >
            [ts]        Key: String -> Value: Dictionary<String, String >
                lat
                lng
                etc
            [ts]        Key: String -> Value: Dictionary<String, String >
                lat
                lng
                etc
            [ts]        Key: String -> Value: Dictionary<String, String >
                lat
                lng
                etc
     */
    
    var entries : Str2Dict2Dict  = Str2Dict2Dict()
    var timer = NSTimer()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        print("Setting up second view!")
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        //locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 10 /* don't send updates unless location changed at least 10 meters */
        
        startLocation = nil
        
        timer = NSTimer.scheduledTimerWithTimeInterval(
            15.0,
            target: self,
            selector: #selector(batchUpdate),
            userInfo: nil,
            repeats: true)
    }
    
    func batchUpdate()  {
        print("Batch update here. Size of queue is " + String(format:"%d", entries.count))
        
        if (entries.count > 0) {
            RestApiClient.sharedInstance.saveEntries(entries)
            //RestApiClient.sharedInstance.debugEntries(entries)
        }
        
        entries.removeAll()
    }

    @IBAction func trackingButtonPressed(sender: AnyObject) {

        if (name.text! == "") {
            print("No name given!!")
            name.setNeedsFocusUpdate()
        }
        else {
            
            if (!tracking) {
                trackingButton.setTitle(
                    String(format:"Stop Tracking %@", name.text!),
                    forState: .Normal)
                locationManager.startUpdatingLocation()
            }
            else {
                trackingButton.setTitle(
                    String(format:"Start Tracking %@", name.text!),
                    forState: .Normal)
                locationManager.stopUpdatingLocation()
            }
            tracking = !tracking
        }
    }
    
    //    Implementing the Application Delegate Methods
    //    When the location manager detects a location change, it calls the
    //    didUpdateToLocation delegate method. Since the view conroller was declared as
    //    the delegate for the location manager in the viewDidLoad method, it is
    //    necessary to now implement this method in the ViewController.swift file:
    
    func dbl2str(dbl : Double) -> String {
        return String(format: "%1.6f", dbl)
    }
    
    
    public func locationManager(manager: CLLocationManager,  didUpdateLocations locations: [CLLocation])
    {
        print ("didUpdateLocations!")
        
        let latestLocation: AnyObject = locations[locations.count - 1]
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"

        if (entries["player"] == nil) {
            entries["player"]           = Dictionary<String,Dictionary<String,String>>()
            entries["player"]!["info"]  = Dictionary<String,String>()
            
            entries["player"]!["info"]!["name"] = "Peter"
        }
        
        if (entries["positions"] == nil) {
            entries["positions"] = [:]
        }
        
        for loc in locations {
            
            let stringDate: String = formatter.stringFromDate(loc.timestamp)
            
            let  entry : [String:String] = [
                "name"      : name.text!,
                "ts"        : stringDate,
                "lat"       : "\(loc.coordinate.latitude)",
                "lng"       : "\(loc.coordinate.longitude)",
                "altitude"  : "\(loc.altitude)",
                "horizAcc"  : "\(loc.horizontalAccuracy)",
                "verticAcc" : "\(loc.verticalAccuracy)"
            ]

            entries["positions"]![stringDate] = entry
        }
        
        /* entries["player"] = [
            "name" : "PETER",
            "positions" : [
                "first" : [ "ts" : "1", "lat" : "33333.55", "lng" : "55555.33", "altitude" : "50" ],
                "second" : [ "ts" : "2", "lat" : "33333.55", "lng" : "55555.33", "altitude" : "50" ],
                "third" : [ "ts" : "3", "lat" : "33333.55", "lng" : "55555.33", "altitude" : "50" ],
                "fourth" : [ "ts" : "4", "lat" : "33333.55", "lng" : "55555.33", "altitude" : "50" ],
                "fifth" : [ "ts" : "5", "lat" : "33333.55", "lng" : "55555.33", "altitude" : "50" ]
            ]
        ]
        */
        
        latitude.text = String(format: "LAT: %.4f",   latestLocation.coordinate.latitude)
        longitude.text = String(format: "LNG: %.4f",  latestLocation.coordinate.longitude)
        horizAccuracy.text = String(format: "ALT: %.4f", latestLocation.altitude)
        altitude.text = String(format: "HACC: %.4f",  latestLocation.horizontalAccuracy)
        verticalAccuracy.text = String(format: "VACC: %.4f", latestLocation.verticalAccuracy)
        
        if startLocation == nil {
            startLocation = latestLocation as! CLLocation
        }
        
        // var distanceBetween: CLLocationDistance =
        // latestLocation.distanceFromLocation(startLocation)
        
        // distance.text = String(format: "%.2f", distanceBetween)
    }
    
    public func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("LOCATION ERROR");
        print(error)
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

