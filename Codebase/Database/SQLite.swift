//
//  SQLite.swift
//  TestSwift
//
//  Created by Myron on 2018/4/18.
//  Copyright © 2018年 Myron. All rights reserved.
//

import Foundation
import SQLite3

/**
 必须导入 libsqlite3.tbd 库
 */
public class SQLite {
    
    // MARK: - Init
    
    /** Defalut SQLite Manager Object */
    public static var `default`: SQLite = SQLite(name: "MySQLite")
    /** Init SQLite Manager Object */
    public init(name: String) {
        self.name = name
    }
    
    // MARK: - Values
    
    /** 数据库名称 */
    public var name: String = ""
    /** 数据库路径，默认 "\(NSHomeDirectory())/Documents/" */
    public var path: String = "\(NSHomeDirectory())/Documents/"
    /** 数据库指针 */
    public var db: OpaquePointer? = nil
    /** 最新的自动 ID 序号 */
    public var last_id: Int {
        return Int(sqlite3_last_insert_rowid(db))
    }
    
    // MARK: - Log
    
    /** 是否打开日记输出 */
    public var is_log: Bool = true
    
    /**  */
    private func output(_ text: String) {
        if is_log {
            print("SQLite: \(text)")
        }
    }
    
    /** Logs Datebase */
    public var log: SQLiteLogsControl?
    
    // MARK: - Open
    
    /** 打开数据库，如果不存在就创建它。 */
    @discardableResult
    public func open() -> Bool {
        objc_sync_enter(self)
        
        if db != nil {
            objc_sync_exit(self)
            return true
        }
        
        let path = "\(self.path)\(name).sqlite"
        guard let c_path = path.cString(using: .utf8) else {
            objc_sync_exit(self)
            return false
        }
        
        if sqlite3_open(c_path, &db) != SQLITE_OK {
            output("open failed - \(path);")
            objc_sync_exit(self)
            return false
        }
        
        output("open success - \(path);")
        objc_sync_exit(self)
        return true
    }
    
    // MARK: - Close
    
    /** 关闭数据库 */
    @discardableResult
    public func close() -> Bool {
        objc_sync_enter(self)
        
        let result = sqlite3_close(db) == SQLITE_OK
        if result {
            db = nil
            output("close success;")
        } else {
            output("close failed - Error: \(error);")
        }
        
        objc_sync_exit(self)
        return result
    }
    
    // MARK: - Execute
    
    /** 执行不返回数据的 SQL 语句: 创表、更新、插入和删除操作. */
    public func execut(sql: String) -> Bool {
        objc_sync_enter(self)
        
        if db == nil {
            output("execut db open faild - \(sql);")
            objc_sync_exit(self)
            return false
        }
        
        guard let c_sql = sql.cString(using: .utf8) else {
            output("execut c_sql faild - \(sql);")
            objc_sync_exit(self)
            return false
        }
        
        var error: UnsafeMutablePointer<Int8>? = nil
        if sqlite3_exec(db, c_sql, nil, nil, &error) != SQLITE_OK {
            output("execut faild - \(sql) - Error: \(self.error);")
            objc_sync_exit(self)
            return false
        }
        
        /** Log */
        if let log = self.log {
            if !sql.contains(SQLiteLogs.table) {
                log.insert(sql: sql)
                output("execut success - \(sql);")
                objc_sync_exit(self)
                return true
            } else {
                objc_sync_exit(self)
                return true
            }
        }
        
        output("execut success - \(sql);")
        objc_sync_exit(self)
        return true
    }
    
    // MARK: - Find
    
    /** 根据 sql 语句查询内容 */
    public func find(sql: String) -> [[String: Any]] {
        objc_sync_enter(self)
        
        if db == nil {
            output("execut db open faild - \(sql);")
            objc_sync_exit(self)
            return []
        }
        
        guard let c_sql = sql.cString(using: .utf8) else {
            output("execut c_sql faild - \(sql);")
            objc_sync_exit(self)
            return []
        }
        
        // 执行检查
        var datas: [[String: Any]] = []
        var statement: OpaquePointer? = nil
        
        // 检查语句
        if sqlite3_prepare_v2(db, c_sql, -1, &statement, nil) != SQLITE_OK {
            output("find faild - \(sql) - Error: \(self.error);")
        } else { // 执行查询
            while sqlite3_step(statement) == SQLITE_ROW { // 遍历每一行
                let columns = sqlite3_column_count(statement)
                var row_data: [String: Any] = [:]
                for i in 0 ..< columns { // 遍历每一列
                    let type = sqlite3_column_type(statement, i)
                    let chars = UnsafePointer<CChar>(sqlite3_column_name(statement, i))!
                    let name = String(cString: chars, encoding: .utf8)!
                    
                    var value: Any
                    switch type {
                    case SQLITE_INTEGER: value = sqlite3_column_int(statement, i)
                    case SQLITE_FLOAT:   value = sqlite3_column_double(statement, i)
                    case SQLITE_TEXT:    value = String(cString: UnsafePointer<CUnsignedChar>(sqlite3_column_text(statement, i)))
                    case SQLITE_BLOB:    value = Data(bytes: sqlite3_column_blob(statement, i), count: Int(sqlite3_column_bytes(statement, i)))
                    default:             value = ""
                    }
                    
                    row_data[name] = value
                }
                datas.append(row_data)
            }
        }
        sqlite3_finalize(statement)
        
        output("find success - \(sql) - \(datas);")
        objc_sync_exit(self)
        return datas
    }
    
    /** 根据 sql 语句查询内容 */
    public func find<T: Any>(sql: String, line: () -> T, datas: (OpaquePointer?, Int32, T, String) -> Void, next: (T) -> Void) {
        objc_sync_enter(self)
        
        if db == nil {
            output("execut db open faild - \(sql);")
            objc_sync_exit(self)
            return
        }
        
        guard let c_sql = sql.cString(using: .utf8) else {
            output("execut c_sql faild - \(sql);")
            objc_sync_exit(self)
            return
        }
        
        // 执行检查
        var statement: OpaquePointer? = nil
        
        // 检查语句
        if sqlite3_prepare_v2(db, c_sql, -1, &statement, nil) != SQLITE_OK {
            output("find faild - \(sql) - Error: \(self.error);")
        } else { // 执行查询
            while sqlite3_step(statement) == SQLITE_ROW { // 遍历每一行
                let object = line()
                let columns = sqlite3_column_count(statement)
                for i in 0 ..< columns { // 遍历每一列
                    let chars = UnsafePointer<CChar>(sqlite3_column_name(statement, i))!
                    let name = String(cString: chars, encoding: .utf8)!
                    datas(statement, i, object, name)
                }
                next(object)
            }
        }
        sqlite3_finalize(statement)
        
        output("find success - \(sql);")
        objc_sync_exit(self)
    }
    
    /** 根据 sql 语句查询内容 */
    public func find<T: Any>(sql: String, line: () -> T, values: (String, Any?) -> Void, next: (T) -> Void) {
        objc_sync_enter(self)
        
        if db == nil {
            output("execut db open faild - \(sql);")
            objc_sync_exit(self)
            return
        }
        
        guard let c_sql = sql.cString(using: .utf8) else {
            output("execut c_sql faild - \(sql);")
            objc_sync_exit(self)
            return
        }
        
        // 执行检查
        var statement: OpaquePointer? = nil
        
        // 检查语句
        if sqlite3_prepare_v2(db, c_sql, -1, &statement, nil) != SQLITE_OK {
            output("find faild - \(sql) - Error: \(self.error);")
        } else { // 执行查询
            while sqlite3_step(statement) == SQLITE_ROW { // 遍历每一行
                let object = line()
                let columns = sqlite3_column_count(statement)
                for i in 0 ..< columns { // 遍历每一列
                    let type = sqlite3_column_type(statement, i)
                    let chars = UnsafePointer<CChar>(sqlite3_column_name(statement, i))!
                    let name = String(cString: chars, encoding: .utf8)!

                    var value: Any?
                    switch type {
                    case SQLITE_INTEGER: value = sqlite3_column_int(statement, i)
                    case SQLITE_FLOAT:   value = sqlite3_column_double(statement, i)
                    case SQLITE_TEXT:    value = String(cString: UnsafePointer<CUnsignedChar>(sqlite3_column_text(statement, i)))
                    case SQLITE_BLOB:    value = Data(bytes: sqlite3_column_blob(statement, i), count: Int(sqlite3_column_bytes(statement, i)))
                    default:             value = nil
                    }
                    values(name, value)
                }
                next(object)
            }
        }
        sqlite3_finalize(statement)
        
        output("find success - \(sql);")
        objc_sync_exit(self)
    }
    
    /** 根据 sql 语句查询单列内容 */
    public func find<T>(sql: String, `default` obj: T, datas: (T) -> Void) {
        objc_sync_enter(self)
        
        if db == nil {
            output("execut db open faild - \(sql);")
            objc_sync_exit(self)
            return
        }
        
        guard let c_sql = sql.cString(using: .utf8) else {
            output("execut c_sql faild - \(sql);")
            objc_sync_exit(self)
            return
        }
        
        // 执行检查
        var statement: OpaquePointer? = nil
        
        // 检查语句
        if sqlite3_prepare_v2(db, c_sql, -1, &statement, nil) != SQLITE_OK {
            output("find faild - \(sql) - Error: \(self.error);")
        } else { // 执行查询
            while sqlite3_step(statement) == SQLITE_ROW { // 遍历每一行
                switch obj {
                case is String:
                    datas(String(cString: sqlite3_column_text(statement, 0)) as! T)
                case is Int:
                    datas(Int(sqlite3_column_int64(statement, 0)) as! T)
                default: break
                }
            }
        }
        sqlite3_finalize(statement)
        
        output("find success - \(sql);")
        objc_sync_exit(self)
    }
    
    /** 根据 sql 语句查询结果数据 */
    public func find<T>(sql: String, `default` value: T) -> T {
        objc_sync_enter(self)
        
        if db == nil {
            output("execut db open faild - \(sql);")
            objc_sync_exit(self)
            return value
        }
        
        guard let c_sql = sql.cString(using: .utf8) else {
            output("execut c_sql faild - \(sql);")
            objc_sync_exit(self)
            return value
        }
        
        // 执行检查
        var statement: OpaquePointer? = nil
        var result: T = value
        
        // 检查语句
        if sqlite3_prepare_v2(db, c_sql, -1, &statement, nil) != SQLITE_OK {
            output("find faild - \(sql) - Error: \(self.error);")
        } else { // 执行查询
            while sqlite3_step(statement) == SQLITE_ROW { // 遍历每一行
                switch value {
                case is String:
                    result = String(cString: sqlite3_column_text(statement, 0)) as! T
                case is Int:
                    result = Int(sqlite3_column_int64(statement, 0)) as! T
                case is Double:
                    result = Double(sqlite3_column_int64(statement, 0)) as! T
                default: break
                }
            }
        }
        sqlite3_finalize(statement)
        
        output("find success - \(sql);")
        objc_sync_exit(self)
        return result
    }
    
    // MARK: - Error
    
    /** 错误信息 */
    public var error: String {
        return String(validatingUTF8:sqlite3_errmsg(db)) ?? ""
    }
    
}


// MARK: - SQL 语句示例

// MARK: Create
/*
var table = "name"
var sql = """
    create table if not exists \(table) (
        column0 integer primary key autoincrement,
        column1 integer,
        column2 real,
        column3 text,
        column4 blob
    )
"""
/** 约束类型 */
enum primary_key: String {
    case unull = "not null"
    case unique = "unique"
    case key = "primary key"
    case check = "check"
    case `default` = "default"
    case auto = "autoincreatement"
}
/** 变量类型 */
enum type: String {
    case null = "null"
    case int  = "integer"
    case real = "real"
    case text = "text"
    case blob = "blob"
}
 */

// MARK: Insert

/*
var table = "name"
var sql = "insert into \(table) values(column1value, 'column2textvalue');"
*/

// MARK: - Update

/*
var table = "name"
var sql = "update \(table) set column = value where colum = value;"
*/

