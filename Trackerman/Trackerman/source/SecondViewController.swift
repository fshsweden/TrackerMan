//
//  SecondViewController.swift
//  Trackerman
//
//  Created by Peter Andersson on 31/07/16.
//  Copyright © 2016 Peter Andersson. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

public typealias Str2StrMap     = [String:String];
public typealias Str2AnyObjMap  = [String:AnyObject];
public typealias Str2Dict       = [String:Dictionary<String,String>];
public typealias Str2Dict2Dict  = [String:Dictionary<String,Dictionary<String,String>>];
public typealias Str2Str2StrMap = [String:Str2StrMap];



public class SecondViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate
{
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var trackingButton: UIButton!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var horizAccuracy: UILabel!
    @IBOutlet weak var verticalAccuracy: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func onInput(sender: AnyObject) {

    }

    var points : [CLLocation] = [
        
    ]
    let regionRadius: CLLocationDistance = 1000
    var tracking : Bool = false
    
    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation! // implicitly unwrapped Optional!
    
    var game : Game = Game()
    
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
    
    var lat = 55.212323
    var lng = 37.416
    
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

        mapView.mapType = MKMapType.Satellite
        
        name.delegate = self
        
        centerMapOnLocation2(lat, longitude: lng)
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
        
        let latestLocation = locations[locations.count - 1]
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
        
        latitude.text           = String(format: "LAT : %.4f", latestLocation.coordinate.latitude)
        longitude.text          = String(format: "LNG : %.4f", latestLocation.coordinate.longitude)
        horizAccuracy.text      = String(format: "ALT : %.4f", latestLocation.altitude)
        altitude.text           = String(format: "HACC: %.4f", latestLocation.horizontalAccuracy)
        verticalAccuracy.text   = String(format: "VACC: %.4f", latestLocation.verticalAccuracy)
        
        if startLocation == nil {
            startLocation = latestLocation
        }
        
        // var distanceBetween: CLLocationDistance =
        // latestLocation.distanceFromLocation(startLocation)
        
        // distance.text = String(format: "%.2f", distanceBetween)
        
        centerMapOnLocation2(latestLocation.coordinate.latitude, longitude: latestLocation.coordinate.longitude)
        

    }
    
    public func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("LOCATION ERROR");
        print(error)
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(
            location.coordinate,
            regionRadius * 0.0025,
            regionRadius * 0.0025
        )
        mapView.setRegion(coordinateRegion, animated: true)
    }

    func centerMapOnLocation2(latitude: Double, longitude: Double) {
        mapView.showsUserLocation = true
        let span = MKCoordinateSpanMake(0.0030, 0.0030)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
        mapView.setRegion(region, animated: true)
    }

    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true);
        return false;
    }
}

