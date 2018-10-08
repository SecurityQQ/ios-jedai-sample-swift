//
//  DiscoverEvent.swift
//  JedAISDKDemo
//
//  Created by Izchak Witman on 07/10/2018.
//  Copyright © 2018 DeveloperMBP. All rights reserved.
//

import Foundation
import JedAI

class DiscoverEvent {
    let id: Int
    let start: Date
    let end: Date?
    let location: Coordinate?
    
    init(id: Int, start: Date, end: Date?, location: Coordinate?) {
        self.id = id
        self.start = start
        self.end = end
        self.location = location
    }
}

class DiscoverActivity: DiscoverEvent {
    let type: ActivityType
    let stopLocation: Coordinate?
    let typeOfDay: String?
    
    init(id: Int, type: ActivityType, start: Date, end: Date?, startLocation: Coordinate?, stopLocation: Coordinate?, typeOfDay: String?) {
        self.type = type
        self.stopLocation = stopLocation
        self.typeOfDay = typeOfDay
        super.init(id: id, start: start, end: end, location: startLocation)
    }
    
    var title: String {
        return type.title
    }
}

/// DiscoverVisit: Same as VisitEvent with safe Poi type & time consideration
class DiscoverVisit: DiscoverEvent {
    var poi: Poi?
   
    init(id: Int, location: CLLocation, start: Date, end: Date?, poi: Poi?) {
        // Makes poi safe.
        if let poi = poi,
            poi.poiId != 0 {
            self.poi = poi
        }
        super.init(id: id, start: start, end: end, location: location.coordinate)
    }
}
