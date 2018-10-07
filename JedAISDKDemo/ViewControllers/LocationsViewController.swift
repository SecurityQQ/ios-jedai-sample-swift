//
//  LocationsViewController.swift
//  JedAISDKDemo
//

import UIKit
import JedAI

class LocationsViewController: UIViewController {

    private var locationHistory = Array<Any>()
    @IBOutlet weak var tableVIew: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Getting location history
        if let data = JedAI.sharedInstance().getLocationHistory() {
            locationHistory = data
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableVIew.reloadData()
    }
}

extension LocationsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        
        // Preparing information about locations to show in table
        
        let location = locationHistory[indexPath.row] as! CLLocation
        let coords = location.coordinate
        let latitude = String(coords.latitude)
        let longitude = String(coords.longitude)
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .medium
        
        // Showing information in table
        
        cell.textLabel?.text = dateFormatter.string(from: location.timestamp)
        cell.detailTextLabel?.text = "lat: " + latitude + " lon: " + longitude
        return cell
    }
    
    
}
