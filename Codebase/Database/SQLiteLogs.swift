//
//  SQLiteLogs.swift
//  Days
//
//  Created by Myron on 2018/6/5.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

public class SQLiteLogsControl {
    
    /** Insert Log */
    public func insert(sql: String, flag_i: Int = 0, flag_s: String = "") {
        let log = SQLite.SQLiteLogs()
        log.id = SQLite.SQLiteLogs.new_id
        log.time = Date().time1970
        log.sql = sql.data(using: .utf8) ?? Data()
        log.flag_i = flag_i
        log.flag_s = flag_s
        log.insert()
    }
    
    /** print Logs */
    public func print_sql_text() {
        let logs = SQLite.SQLiteLogs.find()
        print("-----------------------------------------------------------")
        print("Start to output the SQLite Logs")
        print("-----------------------------------------------------------")
        for log in logs {
            if let text = String(data: log.sql, encoding: .utf8) {
                print("\"\(text)\",")
            } else {
                print("--- error ---")
            }
        }
        print("-----------------------------------------------------------")
        print("End to output the SQLite Logs")
        print("-----------------------------------------------------------")
    }
    
}

// MARK: - Data

extension SQLite {
    
    public class SQLiteLogs: SQLiteProtocol {
        
        /** Init */
        public required init() { }
        
        /** table name */
        public static var table: String = "Myron_SQLiteLogs"
        
        /** id */
        public var id: Int = 0
        
        /** Date */
        public var time: Int = 0
        /**  */
        public var date: Date {
            set { time = newValue.time1970 }
            get { return Date(time: time) }
        }
        
        /** Sql string */
        public var sql: Data = Data()
        
        /** flag date */
        public var flag_i: Int = 0
        /** flag date */
        public var flag_s: String = ""
    }
    
}

