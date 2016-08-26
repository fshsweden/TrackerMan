//
//  LocationEntry.swift
//  Trackerman
//
//  Created by Peter Andersson on 04/08/16.
//  Copyright © 2016 Peter Andersson. All rights reserved.
//

import Foundation

public class LocationEntry {
    
    public var ts: String
    public var lat: Double
    public var lng: Double
    public var altitude: Double
    public var horizAcc: Double
    public var verticAcc: Double
    
    init (ts: String, lat: Double, lng: Double, altitude:Double, horizAcc:Double, verticAcc:Double) {
        self.ts = ts
        self.lat = lat
        self.lng = lng
        self.altitude = altitude
        self.horizAcc = horizAcc
        self.verticAcc = verticAcc
    }
    
    // horizontalAccuracy.text = String(format: "%.4f",  latestLocation.horizontalAccuracy)
    // altitude.text = String(format: "%.4f",   latestLocation.altitude)
    // verticalAccuracy.text = String(format: "%.4f",    latestLocation.verticalAccuracy)
    

}


