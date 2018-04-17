//
//  Ex_Array.swift
//
//  Feature: 扩展 Array，提供便捷功能。
//  Create: 2018-04-17
//

import Foundation

// MARK: - Counts

extension Array {
    
    /** 快速对元素进行运算 */
    public func count(value body: (Element) -> Int) -> Int {
        var c: Int = 0
        forEach({ c += body($0) })
        return c
    }
    
}
