//
//  Ex_DateFormatter.swift
//
//  Feature: 扩展 DateFormatter，提供便捷功能。
//  Create: 2018-04-17
//

import Foundation

// MARK: - Init

extension DateFormatter {
    
    /** 根据格式快速输出格式控制器 */
    public convenience init(_ format: String) {
        self.init()
        self.dateFormat = format
    }
    
}

// MARK: - Easy Object

extension DateFormatter {
    
    /** yyyyMMdd */
    static let int: DateFormatter = DateFormatter("yyyyMMdd")
    /** yyyy-MM-dd */
    static let date: DateFormatter = DateFormatter("yyyy-MM-dd")
    /** HH:mm */
    static let time: DateFormatter = DateFormatter("HH:mm")
    
}
