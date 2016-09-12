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
public class SecondViewController: UIViewController, UITextFieldDelegate, GameClient
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
    var timer = NSTimer()
    var game : Game?
    
    @IBAction func onInput(sender: AnyObject) {

    }

    /*  ----------------------------------------------------------------------------------
     
     
     
        ----------------------------------------------------------------------------------
     */
    override public func viewDidLoad() {
        
        game = Game(theClient: self)

        super.viewDidLoad()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(
            15.0,
            target: self,
            selector: #selector(batchUpdate),
            userInfo: nil,
            repeats: true)

        mapView.mapType = MKMapType.Satellite
        
        name.delegate = self
        
        game!.setupMap("Peter", theMapView: mapView)
    }
    
    /*  ----------------------------------------------------------------------------------
     
     
     
        ----------------------------------------------------------------------------------
     */
    func batchUpdate()  {
        /*
        print("Batch update here. Size of queue is " + String(format:"%d", entries.count))
        if (entries.count > 0) {
            RestApiClient.sharedInstance.saveEntries(entries)
            //RestApiClient.sharedInstance.debugEntries(entries)
        }
        entries.removeAll()
         */
    }
    
    /*  ----------------------------------------------------------------------------------
     
     
     
        ----------------------------------------------------------------------------------
     */
    public func userMovedToLatLng(lat: Float, lng: Float) {
        
    }
    
    /*  ----------------------------------------------------------------------------------
     
     
     
        ----------------------------------------------------------------------------------
     */
    public func userMovedTo(latestLocation: CLLocation) {
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
    }
    
    /*  ----------------------------------------------------------------------------------
     
     
     
        ----------------------------------------------------------------------------------
     */
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
                
                game!.startTracking();
            }
            else {
                trackingButton.setTitle(
                    String(format:"Start Tracking %@", name.text!),
                    forState: .Normal)
                game!.stopTracking();
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
    
    /*  ----------------------------------------------------------------------------------
     
     
     
        ----------------------------------------------------------------------------------
     */
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*  ----------------------------------------------------------------------------------
     
     
     
        ----------------------------------------------------------------------------------
     */
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true);
        return false;
    }
}

