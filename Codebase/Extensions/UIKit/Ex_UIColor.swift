//
//  Ex_UIColor.swift
//  TestSwift
//
//  Created by Myron on 2018/4/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

// MARK: - Init

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
