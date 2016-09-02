//
//  GameProtocol.swift
//  Trackerman
//
//  Created by Peter Andersson on 02/09/16.
//  Copyright © 2016 Peter Andersson. All rights reserved.
//

import Foundation
import CoreLocation

public protocol GameClient {
   
    func userMovedToLatLng(lat: Float, lng: Float)
    func userMovedTo(last:CLLocation)
}
