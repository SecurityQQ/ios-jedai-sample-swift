//
//  TabBarControllerViewController.swift
//  JedAISDKDemo
//

import UIKit
import CoreLocation
import JedAI

class TabBarViewController: UITabBarController {

    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch CLLocationManager.authorizationStatus() {
        // If authorization status is not determined, ask for permissions
            case .notDetermined:
                locationManager = CLLocationManager()
                locationManager.delegate = self
                locationManager.requestAlwaysAuthorization()
            case .authorizedWhenInUse:
                locationManager = CLLocationManager()
                locationManager.delegate = self
                locationManager.requestAlwaysAuthorization()
            
            // If authorization status is permitted - Start the JedAI SDK
            case .authorizedAlways:
                JedAI.sharedInstance().start()
            default:
                break
        }
    }
}

extension TabBarViewController : CLLocationManagerDelegate {
    
    // Starting the JedAI SDK when authorization granted
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            JedAI.sharedInstance().start()
        }
    }
}
