//
//  NotificationPopables.swift
//  JedAISDKDemo
//
//  Created by Izchak Witman on 07/10/2018.
//  Copyright © 2018 DeveloperMBP. All rights reserved.
//

import Foundation
import JedAI

// MARK: - Notification Popables protocol extensions implementation

extension VisitEvent: NotificationPopable {
    var userNotificationTitle: String {
        return VISIT_TYPE(rawValue: UInt(eventType))?.string ?? ""
    }
    
    var userNotificationContent: String {
        var str = "Time: \(eventTimestamp.decodeTimestamp().string(dateStyle: .short, timeStyle: .medium))\n"
            + "Location: (\(location.latitude), \(location.longitude))\n"
        if let poi = poi, poi.poiId != 0 {
            str += "Poi Name: \(poi.name ?? "Unknown"))\n"
                + "Poi Type: \(poi.type ?? "Unknown"))\n"
        } else {
            str += "Unknown Poi\n"
        }
        return str
    }
}

extension ActivityEvent: NotificationPopable {
    var userNotificationTitle: String {
        guard let activity = ActivityType(rawValue: UInt(activity)) else {
            return "Unknown activity type"
        }
        return activity.title
    }
    
    var userNotificationContent: String {
        var str = ""
        str += "Time: \(eventTimestamp.decodeTimestamp().string(dateStyle: .short, timeStyle: .medium))\n"
        str += "Location: (\(location.latitude), \(location.longitude))\n"
        str += "Confidence: \(confidence)"
        return str
    }
}

extension ActivityType {
    var title: String {
        switch self {
        case .UNDEFINED:
            return "Undefined"
        case .STATIONARY:
            return "Stationary"
        case .IN_VEHICLE:
            return "In Vehicle"
        case .CYCLING:
            return "Cycling"
        case .WALKING:
            return "Walking"
        case .RUNNING:
            return "Running"
        case .SLEEPING:
            return "Sleeping"
        }
    }
}
