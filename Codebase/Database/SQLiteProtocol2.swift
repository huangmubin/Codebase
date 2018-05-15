//
//  SQLiteProtocol2.swift
//  Daily
//
//  Created by Myron on 2018/5/15.
//  Copyright © 2018年 Myron. All rights reserved.
//

import Foundation


public protocol SQLiteProtocol2 {
    
    /** id */
    var id: Int { get set }
    
    /** table name */
    static var table: String { get set }
    
    /** key is value's name, value is the value */
    func set(value: Any, to key: String)
    /** return name=value,name=value */
    func get() -> String
    
    /***/
    init()
    
}

// MARK: - Infos

extension SQLiteProtocol2 {
    
    /** Type String to be the table name */
    var table: String { return Self.table }
    
    /** The new_id */
    static var new_id: Int {
        let id = UserDefaults.standard.integer(forKey: table)
        UserDefaults.standard.set(id + 1, forKey: table)
        return id + 1
    }
    
    /** Keys */
    func keys() -> [String] {
        return get().components(separatedBy: [","]).map({ $0.components(separatedBy: ["="])[0] })
    }
    
    /** Values */
    func values() -> [String] {
        return get().components(separatedBy: [","]).map({ $0.components(separatedBy: ["="])[1] })
    }
    
}


// MARK: - Execut

extension SQLiteProtocol2 {
    
    /** Excute the sql */
    static func execut(sql: String) -> Bool {
        return SQLite.default.execut(sql: sql)
    }
    
    /** Excute the sql */
    func execut(sql: String) -> Bool {
        return SQLite.default.execut(sql: sql)
    }
    
}

// MARK: - Create

extension SQLiteProtocol2 {
    
    /** Create the Object Sqlite table */
    @discardableResult static func create() -> Bool {
        let obj = Self.init()
        let keys = obj.keys()
        let values = obj.values()
        var sql = "create table if not exists \(table) ("
        for i in 0 ..< keys.count {
            if values[i].contains("'") {
                
            } else if values[i].contains(".") {
                
            } else {
                sql += "\(keys[i]) inter"
            }
        }
        return execut(sql: sql)
    }
    
}

// MARK: - Find

extension SQLiteProtocol2 {
    
    /** Find */
    static func find(sql: String) -> [Self] {
        var objs = [Self]()
        SQLite.default.find(sql: sql, create: { Self.init() }, next: { objs.append($0) })
        return objs
    }
    
    /** Find some table */
    static func find(where value: String? = nil) -> [Self] {
        var sql = "select * from \(table)"
        if let v = value {
            sql += " where \(v);"
        } else {
            sql += ";"
        }
        return find(sql: sql)
    }
    
}

