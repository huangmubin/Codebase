//
//  CalendarView.swift
//  Days
//
//  Created by Myron on 2018/6/22.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

public protocol CalendarViewDelegate: class {
    func calendar(view: CalendarView, update cell: CalendarView.Collection.Cell, index: IndexPath)
    func calendar(view: CalendarView, update date: Date)
}

/** Calendar View */
public class CalendarView: View {
    
    // MARK: - Values
    
    /**  */
    public weak var delegate: CalendarViewDelegate?

    /**  */
    public var date: Date = Date() {
        didSet {
            delegate?.calendar(view: self, update: date)
        }
    }
    
    /** is auto bounds */
    public var can_bounds: Bool = true
    
    // MARK: - Action
    
    public func update(date: Date) {
        self.date = date
        collect.reloadData()
    }
    
    // MARK: - Sub Views
    
    public var collect: CalendarView.Collection = CalendarView.Collection()
    
    public var week: CalendarView.Week = CalendarView.Week()
    
    // MARK: - Deploy
    
    public override func view_deploy() {
        super.view_deploy()
        week.calendar = self
        collect.calendar = self
        collect.backgroundColor = UIColor.white
        
        addSubview(week)
        addSubview(collect)
    }
    
    public override func view_bounds() {
        super.view_bounds()
        if can_bounds {
            let h = bounds.height / 7
            week.frame = CGRect(
                x: 0, y: 0,
                width: bounds.width,
                height: h
            )
            collect.frame = CGRect(
                x: 0, y: week.frame.maxY,
                width: bounds.width,
                height: h * 6
            )
        }
    }
    
}
