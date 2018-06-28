//
//  Ex_Date.swift
//  TestSwift
//
//  Created by Myron on 2018/4/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import Foundation

// MARK: - Init

extension Date {
    
    /** 根据 20180101 来初始化，如果错误则返回当天日期 */
    public init(_ day: Int) {
        self = DateFormatter.int.date(from: day.description) ?? Date()
    }
    
    /** 根据 时间戳 来初始化，如果错误则返回当天日期 */
    public init(time: Int) {
        self = Date.init(timeIntervalSince1970: TimeInterval(time))
    }
}

// MARK: - Calendar

extension Date {
    
    // MARK: 分解
    
    /**  */
    public var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    /**  */
    public var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    /**  */
    public var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    /** 1 = Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday */
    public var week: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    /**  */
    public var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    /**  */
    public var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    /**  */
    public var second: Int {
        return Calendar.current.component(.second, from: self)
    }
    
    /**  */
    public var time: Int {
        return hour * 3600 + minute * 60 + second
    }
    
    /** 20180101 */
    public var date: Int {
        return year * 10000 + month * 100 + day
    }
    
    /** timeIntervalSince1970 */
    public var time1970: Int {
        return Int(timeIntervalSince1970)
    }
    
    // MARK: 天数
    
    /** 计算天数。
      .year 是计算这一年的天数
      .month 是计算这一个月的天数
      .weekday 默认返回 7
     */
    public func days(_ component: Calendar.Component) -> Int {
        switch component {
        case .year:
            return Calendar.days(year: year)
        case .month:
            return Calendar.days(year: year, month: month)
        case .weekday:
            return 7
        default:
            return 0
        }
    }
    
}

// MARK: - 节点

extension Date {
    
    /**
     获取某个周期的第一天
     .year 年
     .month 月
     .weekday 周
     .day 天
     */
    public func first(_ component: Calendar.Component) -> Date {
        switch component {
        case .year:
            return Calendar.current.date(
                from: Calendar.current.dateComponents(
                    [.year],
                    from: self
                )
            ) ?? self
        case .month:
            return Calendar.current.date(
                from: Calendar.current.dateComponents(
                    [.year, .month],
                    from: self
                )
            ) ?? self
        case .weekday:
            var week: Date = Date()
            var interval: TimeInterval = 0
            if Calendar.current.dateInterval(
                of: .weekOfYear,
                start: &week,
                interval: &interval,
                for: self) {
                return week
            } else {
                return self
            }
        case .day:
            return Calendar.current.date(
                from: Calendar.current.dateComponents(
                    [.year, .month, .day],
                    from: self
                )
            ) ?? self
        default:
            return self
        }
    }
    
    /** 获取下一个周期的第一天 */
    public func next(_ component: Calendar.Component) -> Date {
        return advance(component, 1).first(component)
    }
    
    /** 获取上一个周期的第一天 */
    public func last(_ component: Calendar.Component) -> Date {
        return advance(component, -1).first(component)
    }
    
}

// MARK: - Advance

extension Date {
    
    /** 按秒数进行偏移 */
    public func advance(_ time: TimeInterval) -> Date {
        return self.addingTimeInterval(time)
    }
    
    /**
     按单位进行偏移
     .year
     .month
     .weekday
     .day
     .hour
     .minute
     */
    public func advance(_ component: Calendar.Component, _ length: Int) -> Date {
        switch component {
        case .year:
            let y = year + length
            let m = month
            let d = min(Calendar.days(year: y, month: m), day)
            return Date(y * 10000 + m * 100 + d)
        case .month:
            var y = year
            var m = month + length
            if m < 1 {
                m += 12
                y -= 1
            }
            if m > 12 {
                m -= 12
                y += 1
            }
            let d = min(Calendar.days(year: y, month: m), day)
            return Date(y * 10000 + m * 100 + d)
        case .weekday:
            return advance(604800 * length.double).first(.day)
        case .day:
            return advance(86400 * length.double).first(.day)
        case .hour:
            return advance(3600 * length.double)
        case .minute:
            return advance(60 * length.double)
        default:
            return self
        }
    }
    
}


// MARK: - Chinese

extension Date {
    
    var year_cn: String {
        let value = Calendar.Chinese.obj.component(.year, from: self)
        return Calendar.Chinese.era[(value - 1) % 60]
    }
    
    var month_cn: String {
        let value = Calendar.Chinese.obj.component(.month, from: self)
        return Calendar.Chinese.months[value - 1]
    }
    
    var day_cn: String {
        let value = Calendar.Chinese.obj.component(.day, from: self)
        return Calendar.Chinese.days[value - 1]
    }
    
}
