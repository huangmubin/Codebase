//
//  iDateSelector.swift
//  My
//
//  Created by Myron on 2018/4/24.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

/** Data Selector, use with iSelector.xib */
public class iDateSelector: UIView {
    
    // MARK: - Update
    
    /** update the iSelectors */
    public func update(date: Date) {
        year?.scroll(data: date.year.description, animate: true)
        month?.scroll(data: date.month.description, animate: true)
        day?.scroll(data: date.day.description, animate: true)
        hour?.scroll(data: date.hour.description, animate: true)
        minute?.scroll(data: date.minute.description, animate: true)
        second?.scroll(data: date.second.description, animate: true)
    }
    
    /** Get the date */
    public func date(
        year: Int? = nil,
        month: Int? = nil,
        day: Int? = nil,
        hour: Int? = nil,
        minute: Int? = nil,
        second: Int? = nil
        ) -> Date {
        let ye = year ?? self.year.int
        let mo = month ?? self.month.int
        let da = day ?? self.day.int
        let ho = hour ?? self.hour.int
        let mi = minute ?? self.minute.int
        let se = second ?? self.second.int
        return DateFormatter("yyyy-M-d H:m:s").date(from: "\(ye)-\(mo)-\(da) \(ho):\(mi):\(se)") ?? Date()
    }
    
    // MARK: - iSelectors
    
    @IBOutlet weak var year: iSelector! = iSelector(direction: .vertical)
    @IBOutlet weak var month: iSelector! = iSelector(direction: .vertical)
    @IBOutlet weak var day: iSelector! = iSelector(direction: .vertical)
    @IBOutlet weak var hour: iSelector! = iSelector(direction: .vertical)
    @IBOutlet weak var minute: iSelector! = iSelector(direction: .vertical)
    @IBOutlet weak var second: iSelector! = iSelector(direction: .vertical)
    
}
