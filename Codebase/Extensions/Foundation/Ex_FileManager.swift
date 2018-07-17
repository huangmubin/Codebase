//
//  Ex_FileManager.swift
//  HuaChuang
//
//  Created by Myron on 2018/7/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import Foundation

// MARK: - Normal File Operation

extension FileManager {
    
    public class func exist(_ path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }
    
    public class func read(_ path: String) -> Data? {
        return FileManager.default.contents(atPath: path)
    }
    
    public class func write(_ data: Data, to: String) -> Bool {
        do {
            try data.write(to: URL(fileURLWithPath: to))
            return true
        } catch { }
        return false
    }
    
    public class func remove(_ path: String) -> Bool {
        do {
            try FileManager.default.removeItem(atPath: path)
            return true
        } catch { }
        return false
    }
    
    public class func copy(_ path: String, to: String) -> Bool {
        do {
            if FileManager.default.fileExists(atPath: path) && !FileManager.default.fileExists(atPath: to) {
                var paths = to.components(separatedBy: "/")
                if paths.count <= 1 {
                    return false
                }
                paths.removeLast()
                let directory = paths.joined(separator: "/")
                if !FileManager.default.fileExists(atPath: directory) {
                    try FileManager.default.createDirectory(atPath: directory, withIntermediateDirectories: true, attributes: nil)
                }
                try FileManager.default.copyItem(atPath: path, toPath: to)
                return true
            }
        } catch { }
        return false
    }
    
    public class func move(_ path: String, to: String) -> Bool {
        do {
            if FileManager.default.fileExists(atPath: path) && !FileManager.default.fileExists(atPath: to) {
                var paths = to.components(separatedBy: "/")
                if paths.count <= 1 {
                    return false
                }
                paths.removeLast()
                let directory = paths.joined(separator: "/")
                if !FileManager.default.fileExists(atPath: directory) {
                    try FileManager.default.createDirectory(atPath: directory, withIntermediateDirectories: true, attributes: nil)
                }
                try FileManager.default.moveItem(atPath: path, toPath: to)
                return true
            }
        } catch { }
        return false
    }
    
    public class func create(directory path: String) -> Bool {
        do {
            try FileManager.default.createDirectory(at: URL(fileURLWithPath: path), withIntermediateDirectories: true, attributes: nil)
            return true
        } catch { }
        return false
    }
    
}

// MARK: - Normal File Attribute

extension FileManager {
    
    public class func is_directory(_ path: String) -> Bool {
        if let attribute = try? FileManager.default.attributesOfItem(atPath: path) {
            if let type = attribute[FileAttributeKey.type] as? String {
                return type == FileAttributeType.typeDirectory.rawValue
            }
        }
        return false
    }
    
    public class func size(_ path: String) -> Double {
        if let attribute = try? FileManager.default.attributesOfItem(atPath: path) {
            if let size = attribute[FileAttributeKey.size] as? Double {
                return size
            }
        }
        return 0
    }
    
}

// MARK: - Path

extension FileManager {
    
    public class Path {
        
        public static let home: String = NSHomeDirectory()
        
        public class func documents(_ path: String) -> String {
            return "\(home)/Documents/\(path)"
        }
        
        public class func preferences(_ path: String) -> String {
            return "\(home)/Library/Preferences/\(path)"
        }
        
        public class func caches(_ path: String) -> String {
            return "\(home)/Library/Caches/\(path)"
        }
        
        public class func tmp(_ path: String) -> String {
            return "\(home)/tmp/\(path)"
        }
        
        public class func sub(_ path: String) -> [String] {
            return FileManager.default.subpaths(atPath: path) ?? []
        }
        
    }
    
}

