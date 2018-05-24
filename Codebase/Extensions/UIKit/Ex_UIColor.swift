//
//  Ex_UIColor.swift
//  TestSwift
//
//  Created by Myron on 2018/4/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

// MARK: - Int -> Color

extension UIColor {
    
    /**  */
    public convenience init(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) {
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    
    /** 16进制初始化 */
    public convenience init(_ value: UInt, _ alpha: CGFloat = 1) {
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat((value & 0x0000FF)) / 255.0,
            alpha: alpha
        )
    }
    
    /** 16进制初始化 */
    public convenience init(_ value: Int, _ alpha: CGFloat = 1) {
        self.init(
            red: CGFloat((UInt(value) & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((UInt(value) & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat((UInt(value) & 0x0000FF)) / 255.0,
            alpha: alpha
        )
    }
}

// MARK: - Color -> Int

extension UIColor {
    
    /** 获取颜色的色值 */
    public func number() -> Int {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let r_u = UInt(r * 255) << 16
        let g_u = UInt(g * 255) << 8
        let b_u = UInt(b * 255)
        return Int(r_u + g_u + b_u)
    }
    
}
