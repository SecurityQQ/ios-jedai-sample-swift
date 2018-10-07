//
//  Location.swift
//  JedAISDKDemo
//
//  Created by Izchak Witman on 07/10/2018.
//  Copyright © 2018 DeveloperMBP. All rights reserved.
//

import Foundation
import CoreLocation

typealias Coordinate = CLLocationCoordinate2D

/// Location codable. Decoded from database query result.
class Location: Codable {
    let latitude: Double?
    let longitude: Double?
    
    enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
    }
}

// MARK: - Maps Location to CLLocation
extension Array where Element: Location {
    func cllocations() -> [CLLocation] {
        return compactMap { location in
            if let latitude = location.latitude,
                let longitude = location.longitude {
                return CLLocation(latitude: latitude, longitude: longitude)
            }
            return nil
        }
    }
}

extension CLLocation {
    convenience init(coordinate: Coordinate) {
        self.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}
