//
//  Ex_Int.swift
//
//  Feature: 扩展 Int，提供便捷功能。
//  Create: 2018-04-17
//

import UIKit

// MARK: - Format

extension Int {
    
    /**  */
    var double: Double { return Double(self) }
    
    /**  */
    var float: Float { return Float(self) }
    
    /**  */
    var cgfloat: CGFloat { return CGFloat(self) }
    
    /** count a random in range, default is 0 ..< 101 */
    public static func random(range: Range<Int> = 0 ..< 101) -> Int {
        return Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound))) + range.lowerBound
    }
    
}
