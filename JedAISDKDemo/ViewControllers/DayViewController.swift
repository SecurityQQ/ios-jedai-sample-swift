//
//  DayViewController.swift
//  JedAISDKDemo
//
//  Created by Manuel Kalla on 08.10.18.
//  Copyright © 2018 DeveloperMBP. All rights reserved.
//

import UIKit

class DayViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.visibleViewController?.title = self.tabBarItem.title
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "transportationSegue" {
            
            if let destVC = segue.destination as? TransportTableViewController {
                let button = (sender as? UIButton)!
                destVC.title = button.titleLabel?.text
                
                switch button.titleLabel?.text {
                case "Work":
                    destVC.options = [
                        Transport(name: "Bicycle", duration: 23),
                        Transport(name: "Car", duration: 18),
                        Transport(name: "Walk", duration: 27)
                    ]
                    break
                case "Shopping":
                    destVC.options = [
                        Transport(name: "Walk", duration: 5),
                        Transport(name: "Bicycle", duration: 3)
                    ]
                    break
                case "Climbing":
                    destVC.options = [
                        Transport(name: "Car2Go", duration: 13),
                        Transport(name: "MyTaxi", duration: 13),
                        Transport(name: "Bicycle", duration: 27)
                    ]
                    break
                case "Home":
                    destVC.options = [
                        Transport(name: "Public Transportation", duration: 15),
                        Transport(name: "Car", duration: 13)
                    ]
                    break
                default:
                    break
                }
                
                
            }
        }        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
}

