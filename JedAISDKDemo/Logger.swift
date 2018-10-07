//
//  Logger.swift
//  JedAISDKDemo
//
//  Created by Izchak Witman on 07/10/2018.
//  Copyright © 2018 DeveloperMBP. All rights reserved.
//

import Foundation

enum LogEvent: String {
    case error = "[‼️]"
    case info = "[ℹ️]"
    case debug = "[💬]"
    case verbose = "[🔬]"
    case warning = "[⚠️]"
    case severe = "[🔥]"
}

// Applcation Logger
// HOW TO USE:
// 1. Copy Logger.swift to your project.
// 2. Call from any place of your code log.[error | log.debug | log.warning | info]("[message]")

/// Global log instance of singleton
public let log = Logger.shared

public class Logger {
    // singleton
    static let shared = Logger()
    private init(){}
    // log date-format.
    private var dateFormat = "hh:mm:ssSSS"
    
    public func error(_ message: String,
                      fileName: String = #file,
                      line: Int = #line,
                      column: Int = #column,
                      funcName: String = #function) {
        logMessage(message, event: .error, fileName: fileName, line: line, column: column, funcName: funcName)
    }
    
    public func debug(_ message: String,
                      fileName: String = #file,
                      line: Int = #line,
                      column: Int = #column,
                      funcName: String = #function) {
        logMessage(message, event: .debug, fileName: fileName, line: line, column: column, funcName: funcName)
    }
    
    public func warning(_ message: String,
                        fileName: String = #file,
                        line: Int = #line,
                        column: Int = #column,
                        funcName: String = #function) {
        logMessage(message, event: .warning, fileName: fileName, line: line, column: column, funcName: funcName)
    }
    
    public func info(_ message: String,
                     fileName: String = #file,
                     line: Int = #line,
                     column: Int = #column,
                     funcName: String = #function) {
        logMessage(message, event: .info, fileName: fileName, line: line, column: column, funcName: funcName)
    }
    
    private func logMessage(_ message: String,
                            event: LogEvent,
                            fileName: String = #file,
                            line: Int = #line,
                            column: Int = #column,
                            funcName: String = #function) {
        
        #if DEBUG
        print("\(format(date: Date())) \(event.rawValue)[\(sourceFileName(filePath: fileName))]:\(line) \(funcName) -> \(message)")
        #endif
    }
    
    /// Get formatter by class attribute dateFormat.
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    /// Supply class name which called log.
    private func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
    
    
    /// format to string.
    private func format(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
