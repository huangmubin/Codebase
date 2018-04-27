//
//  Ex_Array.swift
//
//  Feature: 扩展 Array，提供便捷功能。
//  Create: 2018-04-17
//

import UIKit

// MARK: - Counts

extension Array {
    
    /** 快速对元素进行运算 */
    public func count<T: Operator_Addition>(value body: (Element) -> T) -> T {
        var value: T = T()
        forEach({ value = value + body($0) })
        return value
    }
    
}
