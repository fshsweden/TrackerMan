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

class Game {
    var audioPlayer = AVAudioPlayer()
    
    typealias LatLongPointsArray = [CLLocation]
    
    var data : Dictionary<String, LatLongPointsArray> = [:]
    
    
    init() {
        
        if let soundPath  = NSBundle.mainBundle().URLForResource("coin-drop-2", withExtension: "wav") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOfURL: soundPath)
                audioPlayer.prepareToPlay()
            } catch {
                print("No sound found by URL:\(soundPath)")
            }
        }
        else {
            print("Audio URL not found!")
        }
        
        /*  load a path with control points!
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
    }
    
    func play() {
        audioPlayer.play()
    }
    
    func checkMatchAgainstPoint(name: String, newloc : CLLocation) -> Bool {
        
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
    func distance(pt1 : CLLocation,pt2: CLLocation) -> Double {
        return pt2.distanceFromLocation(pt1);
    }
    
}