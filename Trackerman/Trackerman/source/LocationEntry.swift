//
//  LocationEntry.swift
//  Trackerman
//
//  Created by Peter Andersson on 04/08/16.
//  Copyright © 2016 Peter Andersson. All rights reserved.
//

import Foundation

open class LocationEntry {
    
    open var ts: String
    open var lat: Double
    open var lng: Double
    open var altitude: Double
    open var horizAcc: Double
    open var verticAcc: Double
    
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


