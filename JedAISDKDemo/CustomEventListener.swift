//
//  CustomEventListener.swift
//  JedAISDKDemo
//

import UIKit
import JedAI

// this class listen to JedAIEvents
// it stores the incoming events and posts a notificatin in the notification center about the event
class CustomEventListener : NSObject, JedAIEventDelegate {
    
    static let EVENT_NOTIFICATION = "EventNotification"
    
    static let shared = CustomEventListener()
    
    // this array will hold the incoming events
    var events = Array<Any>()
    
    func onEvent(_ event: JedAIEvent) {
        events.append(event)
        // Sending notification about visit event with event object (if someone wants to use them)
        NotificationCenter.default.post(name: Notification.Name(CustomEventListener.EVENT_NOTIFICATION), object: event)
    }
}
