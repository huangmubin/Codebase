//
//  Binary.swift
//  MacOS
//
//  Created by 黄穆斌 on 2018/7/15.
//  Copyright © 2018年 myron. All rights reserved.
//

import Foundation

protocol BinaryProtocol { }

// MARK: - FixedWidthInteger & SignedInteger

extension BinaryProtocol where Self: FixedWidthInteger & SignedInteger {
    
    var uint: UInt { return UInt(self) }
    
}

// MARK: - FixedWidthInteger & UnsignedInteger

extension BinaryProtocol where Self: FixedWidthInteger & UnsignedInteger {
    
    var int: Int { return Int(self) }
    
    /** 获取二进制内容 */
    func binary(prefix: String = "0b_") -> String {
        var result: [String] = []
        for i in 0..<(Self.bitWidth / 8) {
            let byte = UInt8(truncatingIfNeeded: self >> (i * 8))
            let byteString = String(byte, radix: 2)
            let padding = String(repeating: "0", count: 8 - byteString.count)
            result.append(padding + byteString)
        }
        return prefix + result.reversed().joined(separator: "_")
    }
    
    /** 截取指定的位数 */
    func bits(range: Range<Int>) -> Self? {
        if range.upperBound > Self.bitWidth && range.lowerBound >= 0 {
            return nil
        } else {
            var i = self
            i = i << (range.lowerBound)
            i = i >> (Self.bitWidth - range.upperBound + range.lowerBound)
            return i
        }
    }
    
    /** 清除掉指定位数的内容 */
    func bits(clear range: Range<Int>) -> Self {
        var c = self << Self.bitWidth
        c = ~c
        c = c << (Self.bitWidth - range.count)
        c = c >> range.lowerBound
        c = ~c
        return self & c
    }
    
    /** 替换指定的位数 */
    func bits(replace range: Range<Int>, to value: Self) -> Self? {
        if range.upperBound > Self.bitWidth && range.lowerBound >= 0 {
            return nil
        } else {
            let move = Self.bitWidth - range.count
            let v = (value << move) >> range.lowerBound
            let c = bits(clear: range)
            return c | v
        }
    }
}

// MARK: - Extension

extension Int  : BinaryProtocol {}
extension Int8 : BinaryProtocol {}
extension Int16: BinaryProtocol {}
extension Int32: BinaryProtocol {}
extension Int64: BinaryProtocol {}

extension UInt  : BinaryProtocol {}
extension UInt8 : BinaryProtocol {}
extension UInt16: BinaryProtocol {}
extension UInt32: BinaryProtocol {}
extension UInt64: BinaryProtocol {}
