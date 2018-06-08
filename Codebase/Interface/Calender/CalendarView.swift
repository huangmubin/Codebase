//
//  CalenderView.swift
//  TestSwift
//
//  Created by Myron on 2018/5/7.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

// MARK: - Delegate

public protocol CalendarViewDelegate: class {
    func calendar(view: CalendarView, back_color_at index: IndexPath, date: Date) -> UIColor
    func calendar(view: CalendarView, update date: Date)
}

// MARK: - Calendar

public class CalendarView: View, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - Delegate
    
    /** CalendarViewDelegate */
    public weak var delegate: CalendarViewDelegate?

    // MARK: - Data
    
    /** current select date */
    public var date: Date = Date().first(.day) {
        didSet {
            if date != oldValue {
                first = date.first(.month).first(.weekday)
                delegate?.calendar(view: self, update: date)
            }
        }
    }
    
    /** Date advance current time */
    public var current: Date {
        let time = Date()
        return date.advance(Double(time.time))
    }
    
    /** showing first date */
    public var first: Date = Date()
    
    // MARK: - IB
    
    /** label color in month */
    @IBInspectable var color_month: UIColor = UIColor.black
    /** label color un month */
    @IBInspectable var color_unmonth: UIColor = UIColor.lightGray
    
    // MARK: - Deploy
    
    /***/
    public override func view_deploy() {
        super.view_deploy()
        first = date.first(.month).first(.weekday)
    }
    
    // MARK: - Frame
    
    /** cell item size */
    var size: CGSize = CGSize(width: 50, height: 50)
    
    public override func view_bounds() {
        super.view_bounds()
        layoutIfNeeded()
        size = CGSize(
            width: (days.bounds.width - 9) / 7,
            height: (days.bounds.height - 7.5) / 6
        )
        //print("wize = \(size.width); days = \(days.bounds.width); co = \(size.width * 7)")
        //print("size = \(size.height); days = \(days.bounds.height); co = \(size.height * 6)")
        days.reloadData()
    }
    
    // MARK: - Days
    
    /** Days collection view */
    @IBOutlet weak var days: UICollectionView! {
        didSet {
            days.register(
                UINib(nibName: "CalendarCell", bundle: Bundle.main),
                forCellWithReuseIdentifier: "Cell"
            )
        }
    }
    
    /** current select day */
    weak var select_day: CalendarCell?
    
    // MARK: - Collection Delegate
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CalendarCell
        cell.index = indexPath
        cell.date = first.advance(.day, indexPath.row)
        days_update(cell: cell)
        return cell
    }
    
    /** Update the cell status */
    public func days_update(cell: CalendarCell) {
        let day = cell.date!
        cell.back.backgroundColor = delegate?.calendar(view: self, back_color_at: cell.index, date: day)
        if day.month == date.month {
            if day.day == date.day {
                select_day = cell
                cell.day.textColor = UIColor.white
                cell.select.isHidden = false
            } else {
                cell.day.textColor = color_month
                cell.select.isHidden = true
            }
        } else {
            cell.day.textColor = color_unmonth
            cell.select.isHidden = true
        }
        cell.day.text = "\(first.advance(.day, cell.index.row).day)"
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return size
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let new = first.advance(.day, indexPath.row)
        if new.month == date.month {
            if new.day != date.day {
                date = new
                days_update(cell: select_day!)
                days_update(cell: days.cellForItem(at: indexPath) as! CalendarCell)
            }
        }
    }
    
    // MARK: - Month
    
    /**  */
    @IBOutlet weak var month: UIButton! {
        didSet {
            month.setTitle("\(date.year)年\(date.month)月", for: .normal)
        }
    }
    @IBOutlet weak var month_next: UIButton! {
        didSet {
            month_next.setTitle("\((date.month + 1) % 13)月", for: .normal)
        }
    }
    @IBOutlet weak var month_last: UIButton! {
        didSet {
            month_last.setTitle("\((date.month + 12) % 13)月", for: .normal)
        }
    }
    
    /** Update the month buttons */
    public func update_month() {
        month.setTitle("\(date.year)年\(date.month)月", for: .normal)
        month_next.setTitle("\((date.month + 1) % 13)月", for: .normal)
        month_last.setTitle("\((date.month + 12) % 13)月", for: .normal)
    }
    
    /**  */
    @IBAction func month_selected() {
        var offset = -month_select.bounds.height - 100
        if center_y.constant == 0 {
            date = month_select.date(day: date.day)
            days.reloadData()
            update_month()
        } else {
            offset = 0
        }
        month_select.update(date: date)
        UIView.animate(withDuration: 0.25, animations: {
            self.center_y.constant = offset
            self.layoutIfNeeded()
        })
    }
    
    /**  */
    @IBAction func month_advance(_ sender: UIButton) {
        if month_next === sender {
            date = date.advance(.month, 1)
        } else {
            date = date.advance(.month, -1)
        }
        update_month()
        days.reloadData()
    }
    
    // MARK: - Month Select
    
    /**  */
    @IBOutlet weak var center_y: NSLayoutConstraint!
    /**  */
    @IBOutlet weak var month_select: iDateSelector!
    
}
