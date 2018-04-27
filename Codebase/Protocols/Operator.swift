//
//  Operator.swift
//  TestSwift
//
//  Created by 黄穆斌 on 2018/4/27.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

// MARK: - '+' '-'

/** 实现初始化 */
public protocol Initialization {
    init()
}

/** 实现加法 */
public protocol Operator_Addition: Initialization {
    static func + (l: Self, r: Self) -> Self
}

/** 实现减法 */
public protocol Operator_Subtract: Initialization {
    static func - (l: Self, r: Self) -> Self
}

/** 实现加减法 */
public protocol Operator_Addition_Subtract: Operator_Addition, Operator_Subtract {
}

// MARK: - Extension

extension Int: Operator_Addition_Subtract {}
extension Double: Operator_Addition_Subtract {}
extension Float: Operator_Addition_Subtract {}
extension CGFloat: Operator_Addition_Subtract {}
