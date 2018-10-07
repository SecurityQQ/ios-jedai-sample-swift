//
//  JedAIDecodables.swift
//  JedAISDKDemo
//
//  Created by Izchak Witman on 07/10/2018.
//  Copyright © 2018 DeveloperMBP. All rights reserved.
//

import Foundation
import JedAI


// Decodable objects which decoded from database response

struct VisitEventEntity: Codable {
    let id: Int
    let enterTimestamp: Timestamp
    let exitTimestamp: Timestamp
    let latitude: Double
    let longitude: Double
    let poiID: Int?
    let name: String?
    let type: String?
    let poiLatitude: Double?
    let poiLongitude: Double?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case enterTimestamp = "StartTime"
        case exitTimestamp = "EndTime"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case poiID = "PoiId"
        case name = "Name"
        case type = "Type"
        case poiLatitude = "PoiLatitude"
        case poiLongitude = "PoiLongitude"
    }
}

// MARK: - Initialize DiscoverVisit from VisitEventEntity
extension DiscoverVisit {
    convenience init(from entity: VisitEventEntity) {
        var poi: Poi?
        // Create Poi
        if let poiId = entity.poiID,
            poiId != 0 {
            poi = Poi(id: poiId,
                      name: entity.name,
                      type: entity.type,
                      center: Coordinate(latitude: entity.poiLatitude ?? entity.latitude,
                                         longitude: entity.poiLongitude ?? entity.longitude),
                      polygon: nil, // TODO - Implement
                tags: nil,
                polygonType: 0)
        }
        let enter = (entity.enterTimestamp / 1000).decodeTimestamp()
        let exit = entity.exitTimestamp > 0 ? (entity.exitTimestamp / 1000).decodeTimestamp() : nil
        let location = CLLocation(latitude: entity.latitude,
                                  longitude: entity.longitude)
        self.init(id: entity.id, location: location, start: enter, end: exit, poi: poi)
    }
}


struct ActivityEventEntity: Codable {
    let id: Int
    let startTimestamp: Timestamp
    let stopTimestamp: Timestamp
    let activityType: String?
    let startLatitude: Double?
    let startLongitude: Double?
    let stopLatitude: Double?
    let stopLongitude: Double?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case startTimestamp = "StartTime"
        case stopTimestamp = "EndTime"
        case activityType = "Type"
        case startLatitude = "StartLatitude"
        case startLongitude = "StartLongitude"
        case stopLatitude = "EndLatitude"
        case stopLongitude = "EndLongitude"
    }
}

// MARK: - Initial DiscoverActivity from ActivityEventEntity
extension DiscoverActivity {
    convenience init(from entity: ActivityEventEntity) {
        let type = ActivityType(text: entity.activityType)
        let startDate = (entity.startTimestamp / 1000).decodeTimestamp()
        let stopDate = entity.stopTimestamp > 0 ? (entity.stopTimestamp / 1000).decodeTimestamp() : nil
        var startLocation: Coordinate?
        var stopLocation: Coordinate?
        if let lat = entity.startLatitude, let lon = entity.startLongitude {
            startLocation = Coordinate(latitude: lat, longitude: lon)
        }
        if let lat = entity.stopLatitude, let lon = entity.stopLongitude {
            stopLocation = Coordinate(latitude: lat, longitude: lon)
        }
        self.init(id: entity.id,
                  type: type,
                  start: startDate,
                  end: stopDate,
                  startLocation: startLocation,
                  stopLocation: stopLocation)
    }
}

extension ActivityType {
    init(text: String?) {
        switch text {
        case "STATIONARY": self = ActivityType.STATIONARY
        case "IN_VEHICLE": self = ActivityType.IN_VEHICLE
        case "CYCLING": self = ActivityType.CYCLING
        case "WALKING": self = ActivityType.WALKING
        case "RUNNING": self = ActivityType.RUNNING
        case "SLEEPING": self = ActivityType.SLEEPING
        default:
            self = ActivityType.UNDEFINED
        }
    }
}

/// Location response contains nullable attributes.
class LocationEntity: Codable {
    let latitude: Double?
    let longitude: Double?
    
    enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
    }
}

/// Maps [LocationEntity] to [CLLocation]
extension Array where Element: LocationEntity {
    func cllocations() -> [CLLocation] {
        return compactMap { entity in
            if let latitude = entity.latitude, let longitude = entity.longitude {
                return CLLocation(latitude: latitude, longitude: longitude)
            }
            return nil
        }
    }
}

/// Notification response
struct NotificationEntity: Decodable {
    let timestamp: Double
    let eventType: Int
    let confidence: Int?
    
    enum CodingKeys: String, CodingKey {
        case timestamp = "Timestamp"
        case eventType = "EventType"
        case confidence = "Confidence"
    }
}

