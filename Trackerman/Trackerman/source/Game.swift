//
//  Game.swift
//  Videotest
//
//  Created by Peter Andersson on 26/08/16.
//  Copyright © 2016 Peter Andersson. All rights reserved.
//

import Foundation
import AVFoundation
import MapKit
import CoreLocation

class MyGame: NSObject, CLLocationManagerDelegate {
    
    var audioPlayer = AVAudioPlayer()
    
    typealias LatLongPointsArray = [CLLocation]
    
    var data : Dictionary<String, LatLongPointsArray> = [:]

    let regionRadius: CLLocationDistance = 1000
    
    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation! // implicitly unwrapped Optional!
    var entries : Str2Dict2Dict  = Str2Dict2Dict()
    
    var lat = 55.212323
    var lng = 37.416
    
    var name: String = ""
    var client: GameClient
    var mapView: MKMapView? = nil
    
    let formatter = DateFormatter()
    
    /*  -----------------------------------------------------------------------------------------------
     
        The GAME
     
     
        -----------------------------------------------------------------------------------------------
    */
    init(theClient: GameClient) {
        
        client = theClient
        super.init()
        
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        
        // setup sound
        if let soundPath  = Bundle.main.url(forResource: "coin-drop-2", withExtension: "wav") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundPath)
                audioPlayer.prepareToPlay()
            } catch {
                print("No sound found by URL:\(soundPath)")
            }
        }
        else {
            print("Audio URL not found!")
        }
        
        
        /*  load a TEST path with control points!
        */
        var points : LatLongPointsArray = []
        
        points.append(CLLocation(latitude: 60.63527381, longitude: 16.96727335))
        points.append(CLLocation(latitude: 60.63654697, longitude: 16.96432292))
        points.append(CLLocation(latitude: 60.63774642, longitude: 16.96451604))
        points.append(CLLocation(latitude: 60.63901422, longitude: 16.96449459))
        points.append(CLLocation(latitude: 60.6398927,  longitude: 16.96561038))
        points.append(CLLocation(latitude: 60.63993478, longitude: 16.96993411))
        points.append(CLLocation(latitude: 60.6401189,  longitude: 16.97312057))
        points.append(CLLocation(latitude: 60.64051867, longitude: 16.97740138))
        points.append(CLLocation(latitude: 60.63919307, longitude: 16.97966516))
        points.append(CLLocation(latitude: 60.63835665, longitude: 16.98059857))
        points.append(CLLocation(latitude: 60.63723613, longitude: 16.98304474))
        points.append(CLLocation(latitude: 60.63662062, longitude: 16.98541582))
        points.append(CLLocation(latitude: 60.63384277, longitude: 16.98159635))
        points.append(CLLocation(latitude: 60.63327981, longitude: 16.97583497))
        points.append(CLLocation(latitude: 60.63363758, longitude: 16.97231591))
        points.append(CLLocation(latitude: 60.63466352, longitude: 16.96924746))

        data["Bruksparken runt"] = points
        
        setupLocationHandler()
    }
    
    func getEntries() -> Str2Dict2Dict {
        return entries
    }
    
    func clearEntries() {
        entries = [:]
    }

    /*  ----------------------------------------------------------------------------------
     
        ----------------------------------------------------------------------------------
     */
    func setupMap(_ theName:String, theMapView: MKMapView) {
        name = theName
        mapView = theMapView
        centerMapOnLocation2(lat, longitude: lng)
    }
    
    /*  ----------------------------------------------------------------------------------
     
        ----------------------------------------------------------------------------------
     */
    func setupLocationHandler() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        //locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 10 /* don't send updates unless location changed at least 10 meters */
        startLocation = nil
    }

    /*  ----------------------------------------------------------------------------------
     
        ----------------------------------------------------------------------------------
     */
    func startTracking() {
        locationManager.startUpdatingLocation()
    }
    
    /*  ----------------------------------------------------------------------------------
     
        ----------------------------------------------------------------------------------
     */
    func stopTracking() {
        locationManager.stopUpdatingLocation()
    }
    
    /*  ----------------------------------------------------------------------------------
     
        ----------------------------------------------------------------------------------
     */
    func play() {
        audioPlayer.play()
    }
    
    /*  ----------------------------------------------------------------------------------
     
        ----------------------------------------------------------------------------------
     */
    func checkMatchAgainstPoint(_ name: String, newloc : CLLocation) -> Bool {
        
        if let points : LatLongPointsArray = data[name] {
            for p in points {
                if (distance(p, pt2: newloc) < 0.01) {
                    return true
                }
            }
        }
        
        return false
    }
    
    /*  Distance in meters
    */
    /*  ----------------------------------------------------------------------------------
     
        ----------------------------------------------------------------------------------
     */
    func distance(_ pt1 : CLLocation,pt2: CLLocation) -> Double {
        return pt2.distance(from: pt1);
    }
 
    /*  ----------------------------------------------------------------------------------
     
        ----------------------------------------------------------------------------------
     */
    internal func locationManager(_ manager: CLLocationManager,  didUpdateLocations locations: [CLLocation])
    {
        print ("didUpdateLocations!")
        
        let latestLocation = locations[locations.count - 1]
        
        if (entries["player"] == nil) {
            entries["player"]           = Dictionary<String,Dictionary<String,String>>()
            entries["player"]!["info"]  = Dictionary<String,String>()
            
            entries["player"]!["info"]!["name"] = "Peter"
        }
        
        if (entries["positions"] == nil) {
            entries["positions"] = [:]
        }
        
        for loc in locations {
            
            let stringDate: String = formatter.string(from: loc.timestamp)
            
            let  entry : [String:String] = [
                "name"      : name,
                "ts"        : stringDate,
                "lat"       : "\(loc.coordinate.latitude)",
                "lng"       : "\(loc.coordinate.longitude)",
                "altitude"  : "\(loc.altitude)",
                "horizAcc"  : "\(loc.horizontalAccuracy)",
                "verticAcc" : "\(loc.verticalAccuracy)"
            ]
            
            entries["positions"]![stringDate] = entry
        }
        
        client.userMovedTo(latestLocation)
        
        if startLocation == nil {
            startLocation = latestLocation
        }
        
        // var distanceBetween: CLLocationDistance =
        // latestLocation.distanceFromLocation(startLocation)
        
        // distance.text = String(format: "%.2f", distanceBetween)
        
        centerMapOnLocation2(latestLocation.coordinate.latitude, longitude: latestLocation.coordinate.longitude)
    }
    
    /*  ----------------------------------------------------------------------------------
     
        ----------------------------------------------------------------------------------
     */
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LOCATION ERROR");
        print(error)
    }
    
    /*  ----------------------------------------------------------------------------------
     
        ----------------------------------------------------------------------------------
     */
    func centerMapOnLocation(_ location: CLLocation) {
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(
            location.coordinate,
            regionRadius * 0.0025,
            regionRadius * 0.0025
        )
        if (mapView != nil) {
            mapView!.setRegion(coordinateRegion, animated: true)
        }
    }
    
    /*  ----------------------------------------------------------------------------------
     
        ----------------------------------------------------------------------------------
     */
    func centerMapOnLocation2(_ latitude: Double, longitude: Double) {
        if (mapView != nil) {
            mapView!.showsUserLocation = true
            let span = MKCoordinateSpanMake(0.0030, 0.0030)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            mapView!.setRegion(region, animated: true)
        }
    }
    
}
