//
//  Ex_Calendar.swift
//  TestSwift
//
//  Created by Myron on 2018/4/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import Foundation

// MARK: - Leap Year

extension Calendar {
    
    /** 判断是否是 闰年 */
    public static func leap(year: Int) -> Bool {
        return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
    }
    
}

// MARK: - Days

extension Calendar {
    
    /** 计算某一年的天数 */
    public static func days(year: Int) -> Int {
        return leap(year: year) ? 366 : 365
    }
    
    /** 计算某个月的天数 */
    public static func days(year: Int, month: Int) -> Int {
        let total = year * 12 + month
        let month = total % 12
        switch month {
        case 2:
            return leap(year: year) ? 29 : 28
        case 4, 6, 9, 11:
            return 30
        default:
            return 31
        }
    }
    
}
