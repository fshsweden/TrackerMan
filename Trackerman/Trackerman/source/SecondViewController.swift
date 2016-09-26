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



/*  ----------------------------------------------------------------------------------
 
 
 
    ----------------------------------------------------------------------------------
 */
open class SecondViewController: UIViewController, UITextFieldDelegate, GameClient
{
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var trackingButton: UIButton!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var horizAccuracy: UILabel!
    @IBOutlet weak var verticalAccuracy: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var mapView: MKMapView!

    var tracking : Bool = false
    var timer = Timer()
    var game : MyGame?
    
    @IBAction func onInput(_ sender: AnyObject) {

    }

    /*  ----------------------------------------------------------------------------------
     
     
     
        ----------------------------------------------------------------------------------
     */
    override open func viewDidLoad() {
        
        game = MyGame(theClient: self)

        super.viewDidLoad()
        
        name.text = "Peter"
        timer = Timer.scheduledTimer(
            timeInterval: 15.0,
            target: self,
            selector: #selector(batchUpdate),
            userInfo: nil,
            repeats: true)

        mapView.mapType = MKMapType.satellite
        
        name.delegate = self
        
        game!.setupMap("Peter", theMapView: mapView)
    }
    
    /*  ----------------------------------------------------------------------------------
     
     
     
        ----------------------------------------------------------------------------------
     */
    func batchUpdate()  {
        
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
        
        let entries = game!.getEntries()
        print("Batch update here. Size of queue is " + String(format:"%d", entries.count))
        if (entries.count > 0) {
            RestApiClient.sharedInstance.saveEntries(entries)
            //RestApiClient.sharedInstance.debugEntries(entries)
        }
        game!.clearEntries()
    }
    
    /*  ----------------------------------------------------------------------------------
     
     
     
        ----------------------------------------------------------------------------------
     */
    open func userMovedToLatLng(_ lat: Float, lng: Float) {
        /* callback from Game, do something useful */
    }
    
    /*  ----------------------------------------------------------------------------------
     
     
     
        ----------------------------------------------------------------------------------
     */
    open func userMovedTo(_ latestLocation: CLLocation) {
        
        /* callback from Game, do something useful */
        
        latitude.text           = String(format: "LAT : %.4f", latestLocation.coordinate.latitude)
        longitude.text          = String(format: "LNG : %.4f", latestLocation.coordinate.longitude)
        horizAccuracy.text      = String(format: "ALT : %.4f", latestLocation.altitude)
        altitude.text           = String(format: "HACC: %.4f", latestLocation.horizontalAccuracy)
        verticalAccuracy.text   = String(format: "VACC: %.4f", latestLocation.verticalAccuracy)
    }
    
    /*  ----------------------------------------------------------------------------------
     
     
     
        ----------------------------------------------------------------------------------
     */
    @IBAction func trackingButtonPressed(_ sender: AnyObject) {

        if (name.text! == "") {
            print("No name given!!")
            name.setNeedsFocusUpdate()
        }
        else {
            
            if (!tracking) {
                trackingButton.setTitle(
                    String(format:"Stop Tracking %@", name.text!),
                    for: UIControlState())
                
                game!.startTracking();
                self.view.endEditing(true);
            }
            else {
                trackingButton.setTitle(
                    String(format:"Start Tracking %@", name.text!),
                    for: UIControlState())
                game!.stopTracking();
                self.view.endEditing(true);
            }
            tracking = !tracking
        }
    }
    
    //    Implementing the Application Delegate Methods
    //    When the location manager detects a location change, it calls the
    //    didUpdateToLocation delegate method. Since the view conroller was declared as
    //    the delegate for the location manager in the viewDidLoad method, it is
    //    necessary to now implement this method in the ViewController.swift file:
    
    func dbl2str(_ dbl : Double) -> String {
        return String(format: "%1.6f", dbl)
    }
    
    /*  ----------------------------------------------------------------------------------
     
     
     
        ----------------------------------------------------------------------------------
     */
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*  ----------------------------------------------------------------------------------
     
     
     
        ----------------------------------------------------------------------------------
     */
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true);
        return false;
    }
}

