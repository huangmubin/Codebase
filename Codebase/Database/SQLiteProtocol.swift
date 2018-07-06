//
//  SQLiteProtocol.swift
//  Daily
//
//  Created by Myron on 2018/5/15.
//  Copyright © 2018年 Myron. All rights reserved.
//

import SQLite3
import UIKit

// MARK: - Protocol

protocol SQLiteProtocol: Codable {
    /** Init */
    init()
    
    /** table name */
    static var table: String { get set }
    
    /** id */
    var id: Int { get set }
}

// MARK: - Infos

extension SQLiteProtocol {
    
    /** Type String to be the table name */
    var table: String { return Self.table }
    
    /** The new_id */
    static var new_id: Int {
        let id = UserDefaults.standard.integer(forKey: table)
        UserDefaults.standard.set(id + 1, forKey: table)
        return id + 1
    }
    
    /** Get the key and types String */
    static func keys() -> [String] {
        if let key = UserDefaults.standard.array(forKey: "\(table)_create_keys") as? [String] {
            return key
        } else {
            let obj = Self.init()
            let json = try! JSONEncoder().encode(obj)
            let dict = try! JSONSerialization.jsonObject(with: json, options: .mutableContainers) as! [String:Any]
            var cols: [String] = ["id"]
            var types: [String] = ["integer primary key"]
            for (key, value) in dict {
                if key != "id" {
                    cols.append(key)
                    switch value {
                    case is String: types.append("text")
                    case is Int: types.append("integer")
                    case is Double: types.append("real")
                    default: types.append("blob")
                    }
                }
            }
            UserDefaults.standard.set(cols, forKey: "\(table)_create_keys")
            UserDefaults.standard.set(types, forKey: "\(table)_create_types")
            //print("Save \(table)_create_keys: \(cols); \(types)")
            return cols
        }
    }
    
    /** Get the key and types String */
    static func types() -> [String] {
        if let type = UserDefaults.standard.array(forKey: "\(table)_create_types") as? [String] {
            return type
        } else {
            let obj = Self.init()
            let json = try! JSONEncoder().encode(obj)
            let dict = try! JSONSerialization.jsonObject(with: json, options: .mutableContainers) as! [String:Any]
            var cols: [String] = ["id"]
            var types: [String] = ["integer primary key"]
            for (key, value) in dict {
                if key != "id" {
                    cols.append(key)
                    switch value {
                    case is String: types.append("text")
                    case is Int: types.append("integer")
                    case is Double: types.append("real")
                    default: types.append("blob")
                    }
                }
            }
            UserDefaults.standard.set(cols, forKey: "\(table)_create_keys")
            UserDefaults.standard.set(types, forKey: "\(table)_create_types")
            return types
        }
    }
    
}

// MARK: - Execute

extension SQLiteProtocol {
    
    /** Excute the sql */
    static func execute(sql: String) -> Bool {
        return SQLite.default.execute(sql: sql)
    }
    
    /** Excute the sql */
    func execute(sql: String) -> Bool {
        return SQLite.default.execute(sql: sql)
    }
    
}

// MARK: - Create

extension SQLiteProtocol {
    
    /** Create the Object Sqlite table */
    @discardableResult static func create() -> Bool {
        if UserDefaults.standard.bool(forKey: "SQLite.create.Databases.\(table)") {
            return true
        } else {
            var sql = "create table if not exists \(table) ("
            let keys = Self.keys()
            let type = Self.types()
            for i in 0 ..< keys.count {
                sql += "\(keys[i]) \(type[i]), "
            }
            sql.removeLast()
            sql.removeLast()
            sql += ");"
            if execute(sql: sql) {
                UserDefaults.standard.set(true, forKey: "SQLite.create.Databases.\(table)")
                return true
            } else {
                return false
            }
        }
    }
    
}

// MARK: - Find

extension SQLiteProtocol {
    
    /** Find */
    static func find(sql: String) -> [Self] {
        var objs = [Self]()
        let dics = SQLite.default.find(sql: sql)
        for dic in dics {
            let data = try! JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.prettyPrinted)
            let obj = try! JSONDecoder().decode(Self.self, from: data)
            objs.append(obj)
        }
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

// MARK: - Insert

extension SQLiteProtocol {
    
    /** Insert self to the table*/
    @discardableResult func insert() -> Bool {
        var sql = "insert into \(table) values("
        let json = try! JSONEncoder().encode(self)
        let dict = try! JSONSerialization.jsonObject(with: json, options: .mutableContainers) as! [String:Any]
        let keys = Self.keys()
        for key in keys {
            if dict[key] is String {
                sql += "'\(dict[key]!)', "
            } else {
                sql += "\(dict[key]!), "
            }
        }
        sql.removeLast()
        sql.removeLast()
        sql += ");"
        return execute(sql: sql)
    }
    
}

// MARK: - Update

extension SQLiteProtocol {
    
    /** Update the data */
    @discardableResult func update() -> Bool {
        var sql = "update \(table) set "
        let json = try! JSONEncoder().encode(self)
        let dict = try! JSONSerialization.jsonObject(with: json, options: .mutableContainers) as! [String:Any]
        let keys = Self.keys()
        for key in keys {
            if key != "id" {
                if dict[key] is String {
                    sql += "\(key) = '\(dict[key]!)', "
                } else {
                    sql += "\(key) = \(dict[key]!), "
                }
            }
        }
        sql.removeLast()
        sql.removeLast()
        sql += " where id = \(id);"
        return execute(sql: sql)
    }
    
    /** Update the data */
    @discardableResult func update(_ values: String) -> Bool {
        let sql = "update \(table) set \(values) where id = \(id)"
        return execute(sql: sql)
    }
    
}

// MARK: - Delete

extension SQLiteProtocol {
    
    /** Delete self */
    @discardableResult func delete() -> Bool {
        let sql = "delete from \(table) where id = \(id);"
        return execute(sql: sql)
    }
    
}
