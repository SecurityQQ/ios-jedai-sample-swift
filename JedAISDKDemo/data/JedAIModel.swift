//
//  JedAIModel.swift
//  JedAISDKDemo
//
//  Created by Izchak Witman on 07/10/2018.
//  Copyright © 2018 DeveloperMBP. All rights reserved.
//

import Foundation

import JedAI
import FMDB
import SSZipArchive

/// JedAI SDK model class, responsible for intergration with JedAI SDK.
public class JedAIModel {
    // MARK: - Location
    /// Returns last location from sdk.
    static func lastLocation() -> CLLocation? {
        let location = JedAI.sharedInstance().getLastLocation()
        if location == nil {
            log.info("Unknown last location")
        }
        return location
    }
    
    /// Returns location history from specified date.
    static func getHistory(since: Date) -> [CLLocation] {
        let history = JedAI.sharedInstance()
            .getLocationHistory(byPredicate: JedAIQueries.locationHistory(since: since)) ?? []
        if history.isEmpty {
            log.info("No location history found")
        }
        return history
    }
    
    /// Returns all Visits of specified id.
    static func poiVisitHistory(id: Int) -> [DiscoverVisit] {
        let history: [VisitEventEntity] = JedAIDatabase.shared
            .poiVisitHistory(id: id) ?? []
        let result = history.map { DiscoverVisit(from: $0) }
        return result
    }
    
    // Returns all types of activities in percentage
    static func poiVisitActivities(since: Date?, until: Date?, typeOfDay: String?) -> [String: Double] {
        let history: [ActivityEventEntity] = JedAIDatabase.shared.activityEvents(since: since, until: until) ?? []
        var result: [String] = []
        
        if let typeOfDay = typeOfDay {
            result = history.map { DiscoverActivity(from: $0) }
                .filter { $0.typeOfDay == typeOfDay }
                .map({$0.type.title})
        } else {
            result = history.map { DiscoverActivity(from: $0).type.title}
        }
        let counts = result.reduce(into: [:]) { counts, word in counts[word, default: 0] += 1}
        var ratios : [String: Double] = [:]
        for (k, v) in counts {
            ratios[k] = 100.0 * Double(v) / Double(result.count)
        }
        
        return ratios
    }
    
    static func getActivitiesByType(typeOfDay: String?) -> [String: Double] {
        let dateSince = Date.distantPast
        let dateUntil = Date.distantFuture
        let counterEvents = poiVisitActivities(since: dateSince, until: dateUntil, typeOfDay: typeOfDay)
        return counterEvents
    }
    
    static func getActivies() -> [String:[String: Double]] {
        let typesOfDay = ["Morning", "Afternoon", "Evening"]
        var result : [String: [String: Double]] = [:]
        for t in typesOfDay {
            let subres = getActivitiesByType(typeOfDay: t)
            result[t] = subres
        }
        return result
    }
    
    
    
//    static func getUserType() -> String {
//        activities = getAllActivitiesRatio()
//    }

    
    /// Clears all client's visits from sdk.
    static func clearVisitDatabase() {
        DevTools.clearVisitTable()
        log.info("Visits database has been cleared.")
    }
    
}

// MARK: - Visit Simulation
extension JedAIModel {

    static func simulateVisitEnd(location: Coordinate) {
        let dateEnd = Date()
        guard let dateStart = Calendar.current
            .date(byAdding: .minute, value: -30, to: dateEnd) else {
                return
        }
        let builder = SimulatedVisitBuilder()
            .setCoordinate(location)
            .setAccuracy(1)
            .setVisitStart(dateStart)
            .setVisitEnd(dateEnd)
        DevTools.simulateEvent(builder)
    }

    static func simulateVisitStart(location: Coordinate) {
        let dateEnd = Date()
        guard let dateStart = Calendar.current
            .date(byAdding: .minute, value: -30, to: dateEnd) else {
                return
        }
        let builder = SimulatedVisitBuilder()
            .setCoordinate(location)
            .setAccuracy(1)
            .setVisitStart(dateStart)
            .setVisitEnd(nil)
        DevTools.simulateEvent(builder)
    }

    static func simulateVisitTest() {
            JedAIModel.simulateVisitStart(location: Coordinate(latitude: 48.7914172, longitude: 9.2281041))
            JedAIModel.simulateVisitEnd(location: Coordinate(latitude: 48.7914172, longitude: 9.2281041))
    }
}

