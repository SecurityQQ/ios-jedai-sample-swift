//
//  Queries.swift
//  JedAISDKDemo
//

import UIKit
import JedAI
import FMDB

// sample queries for working with the jedai database
class Queries: NSObject {
 
    func visitEvents(since: Date?, until: Date?) -> [Any]? {
        let since = (since?.timeIntervalSince1970 ?? 0) * 1000
        let until = (until?.timeIntervalSince1970 ?? 0) * 1000
        let predicate = """
        SELECT Visit._id as id, EnterTimestamp as StartTime, ExitTimestamp as EndTime, Latitude, Longitude, PoiId, Name, Type, CenterLatitude AS PoiLatitude, CenterLongitude as PoiLongitude FROM \
        Visit LEFT JOIN VisitedPois \
        ON VisitedPois._id=PoiId \
        WHERE (\(since)<EnterTimestamp OR \(since)=0) \
        AND (\(until)>EnterTimestamp OR \(until)=0) \
        ORDER BY EnterTimestamp DESC
        """
        let result = JedAI.sharedInstance().getVisitEvents(byPredicate: predicate)
        return result
    }
    
    func activityEvents(since: Date?, until: Date?) -> FMResultSet? {
        let since = (since?.timeIntervalSince1970 ?? 0) * 1000
        let until = (until?.timeIntervalSince1970 ?? 0) * 1000
        let predicate = """
        SELECT act._id as id, StartTimestamp as StartTime, StopTimestamp as EndTime, locStart.Latitude as StartLatitude, locStart.Longitude as StartLongitude, locStop.Latitude as EndLatitude, locStop.Longitude as EndLongitude, Confidence, VehicleType \
        FROM Activity as act LEFT JOIN Location as locStart ON locStart._id=StartLocationId LEFT JOIN Location as locStop ON locStop._id=StopLocationId \
        WHERE (\(since)<StartTimestamp OR \(since)=0) \
        AND (\(until)>StartTimestamp OR \(until)=0) \
        ORDER BY act.StartTimestamp DESC
        """
        let result = JedAI.sharedInstance().getActivitiesBySqlQuery(predicate)
        return result
    }
    
    func locationHistory(since: Date) -> [CLLocation]? {
        let predicate = "SELECT * FROM Location WHERE LocationTime > \(since.timeIntervalSince1970)"
        let result = JedAI.sharedInstance().getLocationHistory(byPredicate: predicate)
        return result
    }
}

class JedAIQueries {
    static func poiVisitHistory(id: Int) -> String {
        return """
        SELECT Visit._id as id, EnterTimestamp as StartTime, ExitTimestamp as EndTime, Latitude, Longitude, PoiId, Name, Type, CenterLatitude AS PoiLatitude, CenterLongitude as PoiLongitude FROM \
        Visit LEFT JOIN VisitedPois \
        ON VisitedPois._id=PoiId \
        WHERE (\(id)=PoiId) \
        ORDER BY EnterTimestamp DESC
        """
    }
    
    static func visitEvents(since: Date?, until: Date?) -> String {
        let since = (since?.timeIntervalSince1970 ?? 0) * 1000
        let until = (until?.timeIntervalSince1970 ?? 0) * 1000
        return """
        SELECT Visit._id as id, EnterTimestamp as StartTime, ExitTimestamp as EndTime, Latitude, Longitude, PoiId, Name, Type, CenterLatitude AS PoiLatitude, CenterLongitude as PoiLongitude FROM \
        Visit LEFT JOIN VisitedPois \
        ON VisitedPois._id=PoiId \
        WHERE (\(since)<EnterTimestamp OR \(since)=0) \
        AND (\(until)>EnterTimestamp OR \(until)=0) \
        ORDER BY EnterTimestamp DESC
        """
    }
    
    static func activityEvents(since: Date?, until: Date?) -> String {
        let since = (since?.timeIntervalSince1970 ?? 0) * 1000
        let until = (until?.timeIntervalSince1970 ?? 0) * 1000
         return """
        SELECT act._id as id, StartTimestamp as StartTime, StopTimestamp as EndTime, locStart.Latitude as StartLatitude, locStart.Longitude as StartLongitude, locStop.Latitude as EndLatitude, locStop.Longitude as EndLongitude, Confidence, VehicleType \
        FROM Activity as act LEFT JOIN Location as locStart ON locStart._id=StartLocationId LEFT JOIN Location as locStop ON locStop._id=StopLocationId \
        WHERE (\(since)<StartTimestamp OR \(since)=0) \
        AND (\(until)>StartTimestamp OR \(until)=0) \
        ORDER BY act.StartTimestamp DESC
        """
    }
    
    
    static func locationHistory(since: Date) -> String {
        return "SELECT * FROM Location WHERE LocationTime > \(since.timeIntervalSince1970)"
    }
}
