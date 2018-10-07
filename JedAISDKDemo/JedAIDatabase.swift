//
//  JedAIDatabase.swift
//  JedAISDKDemo
//
//  Created by Izchak Witman on 07/10/2018.
//  Copyright © 2018 DeveloperMBP. All rights reserved.
//

import Foundation
import FMDB
import JedAI

class JedAIDatabase {
    static let shared = JedAIDatabase()
    
    /// JedAI database connection
    var connection: FMDatabase {
        let path = JedAI.sharedInstance().databaseFilePath()
        let connection = FMDatabase(path: path)
        if connection.open() {
            log.info("database opening succeed")
        } else {
            log.info("database opening failed")
        }
        return connection
    }
    
    /// Common query executor & json decoder to an object.
    func loadData<T: Decodable>(from query: String) -> [T]? {
        guard let fmResult = connection.executeQuery(query, withArgumentsIn: []) else {
            log.error("Error while executing query " + query)
            return nil
        }
        var jsonArray: [[String : Any]] = []
        while fmResult.next() {
            jsonArray.append(fmResult.resultDictionary as? [String: Any] ?? [:])
        }
        // Decode result
        let result: [T]? = jsonArray.compactMap { json in
            let decoded: T? = json.decode()
            if decoded == nil {
                log.error("Error while decoding \(json)")
            }
            return decoded
        }
        return result
    }
    
    func update(query: String) {
        do {
            try connection.executeUpdate(query, values: nil)
        } catch let error {
            log.error(error.localizedDescription)
        }
    }
}

// Generic decode [String: Any] to Decodable.
extension Dictionary where Value: Any {
    func decode<T: Decodable>() -> T? {
        var result: T?
        do {
            let json = try JSONSerialization.data(withJSONObject: self)
            result = try JSONDecoder().decode(T.self, from: json)
            
        } catch let error {
            log.error(error.localizedDescription)
        }
        return result
    }
}

extension JedAIDatabase {
    /// Loads Visits from database
    func visitEvents(since: Date?, until: Date?) -> [VisitEventEntity]? {
        let query = JedAIQueries.visitEvents(since: since, until: until)
        return loadData(from: query)
    }
    
    /// Loads Activities entities from database
    func activityEvents(since: Date?, until: Date?) -> [ActivityEventEntity]? {
        let query = JedAIQueries.activityEvents(since: since, until: until)
        return loadData(from: query)
    }
    
    /// Loads all Visits of specified poiId
    func poiVisitHistory(id: Int) -> [VisitEventEntity]? {
        let query = JedAIQueries.poiVisitHistory(id: id)
        return loadData(from: query)
    }
}

