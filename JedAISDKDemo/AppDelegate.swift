//
//  AppDelegate.swift
//  JedAISDKDemo
//

import UIKit
import JedAI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        // Initializing the JedAI SDK
        JedAI.sharedInstance().setup()
        JedAI.sharedInstance().setActivityRecognitionEnabled(true)
   
        let builder = EventConfigBuilder()
        // Adding the event conditions
        // This example registers all events
        builder.onEventTypes(UInt(Int(VISIT_TYPE.VISIT_START_EVENT_TYPE.rawValue) |
            Int(VISIT_TYPE.VISIT_END_EVENT_TYPE.rawValue) |
            Int(VISIT_TYPE.ACTIVITY_CONFIDENCE_CHANGE_EVENT_TYPE.rawValue) |
            Int(VISIT_TYPE.ACTIVITY_START_EVENT_TYPE.rawValue) |
            Int(VISIT_TYPE.ACTIVITY_END_EVENT_TYPE.rawValue)))
        
        // Registering to the event listener with the new builder configuration
        JedAI.sharedInstance().registerEvents(CustomEventListener.shared, eventConfig: builder.build())
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        JedAI.sharedInstance().unregisterEvents(CustomEventListener.shared)
    }


}

