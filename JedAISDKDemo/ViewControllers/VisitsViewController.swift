//
//  VisitsViewController.swift
//  JedAISDKDemo
//

import UIKit
import JedAI

class VisitsViewController: UIViewController {

    private var visits = Array<VisitEventEntity>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // loading all visits to array
        visits = JedAIDatabase.shared.visitEvents(since: nil, until: nil)!
        
    }
}

extension VisitsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VisitCell", for: indexPath)
        
        // Preparing information about visits to show in table
        let visit = visits[indexPath.row]
        let visitTime = Date(timeIntervalSince1970: TimeInterval(visit.enterTimestamp/1000))
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .medium
        
        // Showing in table
        cell.textLabel?.text = visit.name ?? "No name"
        cell.detailTextLabel?.text = dateFormatter.string(from: visitTime)
        
        return cell
    }
    
    
}
