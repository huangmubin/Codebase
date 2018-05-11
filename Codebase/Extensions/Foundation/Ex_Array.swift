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

// MARK: - Find

extension Array {
    
    /** 快速查找并获取元素 */
    public func find(condition body: (Element) throws -> Bool) -> Element? {
        do {
            if let index = try self.index(where: body) {
                return self[index]
            }
        } catch { }
        return nil
    }
    
}

// MARK: - 快速交换位置

extension Array {
    
    /** 快速交换两个元素的位置 */
    public mutating func change(source: Int, destination: Int) {
        if source != destination {
            let a = Swift.min(source, destination)
            let b = Swift.max(source, destination)
            let item_a = self.remove(at: a)
            self.insert(item_a, at: b)
            let item_b = self.remove(at: b-1)
            self.insert(item_b, at: a)
        }
    }
    
    public mutating func move(source: Int, destination: Int) {
        if source != destination {
            let item = self.remove(at: source)
            self.insert(item, at: (source > destination) ? destination : (destination - 1))
        }
    }
    
}
