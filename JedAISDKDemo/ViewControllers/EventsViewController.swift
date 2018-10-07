//
//  EventsViewController.swift
//  JedAISDKDemo
//

import UIKit
import CoreLocation
import JedAI
import SSZipArchive

class EventsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    static let shared = EventsViewController()
    
    var events = Array<Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register for Visit Event Notification
        NotificationCenter.default.addObserver(self, selector: #selector(self.eventNotificationHandler(notification:)),
                                               name: Notification.Name(CustomEventListener.EVENT_NOTIFICATION), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
       // NotificationCenter.default.removeObserver(self)
    }
    
    @objc func eventNotificationHandler(notification: Notification) {
        
        // Process notification
        events = CustomEventListener.shared.events
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    
    // this is used to import zipped database file into the application
    let documentPicker: UIDocumentPickerViewController = UIDocumentPickerViewController(documentTypes: ["public.data","public.content","public.audiovisual-content","public.movie","public.audiovisual-content","public.video","public.audio","public.text","public.data","public.zip-archive","com.pkware.zip-archive","public.composite-content","public.text"], in: UIDocumentPickerMode.import)
    
    @IBAction func didPressLoadButton(_ sender: UIBarButtonItem) {
        
        // Initialize document picker
    
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        
        // Present Document Picker View Controller
        self.present(documentPicker, animated: true, completion: nil)
        
    }
    
}

// Expecting the JedAIEvent events
extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)

        // Preparing information about real time event to show in table
        var eventTypeName = String()
        let event = events[indexPath.row] as! JedAIEvent
        
        var description = ""

        switch event.eventType {
        case Int(VISIT_TYPE.VISIT_START_EVENT_TYPE.rawValue):
            let visit = event as! VisitEvent
            description = visit.poi?.name ?? "NO NAME"
            eventTypeName = "Visit start"
            break;
        case Int(VISIT_TYPE.VISIT_END_EVENT_TYPE.rawValue):
            let visit = event as! VisitEvent
            description = visit.poi?.name ?? "NO NAME"
            eventTypeName = "Visit end"
            break;
        case Int(VISIT_TYPE.ACTIVITY_CONFIDENCE_CHANGE_EVENT_TYPE.rawValue):
            let activity = event as! ActivityEvent
            description = activity.userNotificationTitle
            eventTypeName = "Activity confidence change"
            break;
        case Int(VISIT_TYPE.ACTIVITY_START_EVENT_TYPE.rawValue):
            let activity = event as! ActivityEvent
            description = activity.userNotificationTitle
            eventTypeName = "Activity start"
            break;
        case Int(VISIT_TYPE.ACTIVITY_END_EVENT_TYPE.rawValue):
            let activity = event as! ActivityEvent
            description = activity.userNotificationTitle
            eventTypeName = "Activity end"
            //builder.hasPoiNames(["Airport","Park","Shop"])
            break;
        default:
            eventTypeName = "Unknown"
            break;
        }
        
        let eventTime = Date(timeIntervalSince1970: TimeInterval(event.eventTimestamp))
        
        // Initialize date formatter
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .medium
        
        // Showing info about real time event in table
        
        cell.textLabel?.text = description
        cell.detailTextLabel?.text = eventTypeName + " " + dateFormatter.string(from: eventTime)
        
        return cell
    }
}

// handling the replacement of the database with external zipped database file
extension EventsViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if controller.documentPickerMode == UIDocumentPickerMode.import {
          
            let oldDatabaseUrl = URL.init(fileURLWithPath: JedAI.sharedInstance().databaseFilePath())
            var didSuccess = FileManager.default.fileExists(atPath: oldDatabaseUrl.path)
            print("old database file was found:\(didSuccess)")
            try? FileManager.default.removeItem(at: oldDatabaseUrl)
            didSuccess = FileManager.default.fileExists(atPath: oldDatabaseUrl.path)
            print("old database file was removed:\(didSuccess)")
            let pathToDB = JedAI.sharedInstance().databaseFilePath().replacingOccurrences(of: "main.db", with: "")
            didSuccess = SSZipArchive.unzipFile(atPath: urls.first?.path ?? "", toDestination: pathToDB)
            print("new database file was unzipped:\(didSuccess)")
            
            let alert = UIAlertController(title: "Alert", message: "Restart application to enable database changes", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("documentPickerWasCancelled")
    }
}

