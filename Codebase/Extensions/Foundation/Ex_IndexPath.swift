//
//  Ex_IndexPath.swift
//
//  Feature: 扩展 IndexPath，提供便捷功能。
//  Create: 2018-04-17
//

import Foundation

// MARK: - Init

extension IndexPath {
    
    /** 创建指向数组最后一个元素的坐标 */
    public init<T>(_ array: Array<T>, sec: Int = 0) {
        self = IndexPath(row: array.count - 1, section: sec)
    }
    
}
