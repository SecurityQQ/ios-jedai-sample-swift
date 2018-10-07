//
//  EventType.swift
//  JedAISDKDemo
//
//  Created by Izchak Witman on 07/10/2018.
//  Copyright © 2018 DeveloperMBP. All rights reserved.
//

import Foundation
import JedAI

extension VISIT_TYPE {
    var string: String {
        switch self {
        case .VISIT_START_EVENT_TYPE:
            return "Visit Start"
        case .VISIT_END_EVENT_TYPE:
            return "Visit End"
        case .GEOFENCE_ENTER_EVENT_TYPE:
            return "Geofence Enter"
        case .GEOFENCE_EXIT_EVENT_TYPE:
            return "Geofence Exit"
        case .ACTIVITY_START_EVENT_TYPE:
            return "Activity Start"
        case .ACTIVITY_END_EVENT_TYPE:
            return "Activity End"
        case .ACTIVITY_CONFIDENCE_CHANGE_EVENT_TYPE:
            return "Activity Confidence Change"
        default: return ""
        }
    }
}
