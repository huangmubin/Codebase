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

// MARK: - Chinese

extension Calendar {
    
    class Chinese {
        
        static let obj: Calendar = Calendar(identifier: .chinese)
        
        static let era: [String] = [
            "甲子", "乙丑", "丙寅", "丁卯", "午辰", "己巳", "庚午", "辛未", "壬申", "癸酉",
            "甲戌", "乙亥", "丙子", "丁丑", "午寅", "己卯", "庚辰", "辛巳", "壬午", "癸未",
            "甲申", "乙酉", "丙戌", "丁亥", "午子", "己丑", "庚寅", "辛卯", "壬辰", "癸巳",
            "甲午", "乙未", "丙申", "丁酉", "午戌", "己亥", "庚子", "辛丑", "壬寅", "癸卯",
            "甲辰", "乙巳", "丙午", "丁未", "午申", "己酉", "庚戌", "辛亥", "壬子", "癸丑",
            "甲寅", "乙卯", "丙辰", "丁巳", "午午", "己未", "庚申", "辛酉", "壬戌", "癸亥"
        ]
        
        static let tian_gan: [String] = ["甲", "乙", "丙", "丁", "午", "己", "庚", "辛", "壬", "癸"]
        static let di_zhi: [String] = ["子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"]
        static let zodiacs: [String] = ["鼠", "牛", "虎", "兔", "龙", "色", "马", "羊", "猴", "鸡", "狗", "猪"]
        static let months: [String] = ["正月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "冬月", "腊月"]
        static let days: [String] = [
            "初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十",
            "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十",
            "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十", "三一"
        ]
        
    }
    
}
