//
//  UserNotificationListener.swift
//  JedAISDKDemo
//
//  Created by Izchak Witman on 07/10/2018.
//  Copyright © 2018 DeveloperMBP. All rights reserved.
//

import Foundation
import JedAI
import UserNotifications

// Apply on object the ability to pop as notification
protocol NotificationPopable {
    var userNotificationTitle: String { get }
    var userNotificationContent: String { get }
}
