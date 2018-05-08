//
//  CalendarCell.swift
//  TestSwift
//
//  Created by Myron on 2018/5/7.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

public class CalendarCell: UICollectionViewCell {
    
    // MARK: - Data
    
    public var index: IndexPath!
    public var date: Date!
    
    // MARK: - SubView
    
    /** 日期 */
    @IBOutlet weak var day: UILabel!
    /** 背景 */
    @IBOutlet weak var back: View!
    /** 选中状态 */
    @IBOutlet weak var select: View!

    // MARK: - Size
    
    override public var frame: CGRect {
        didSet{
            if frame.size != oldValue.size {
                view_bounds()
            }
        }
    }
    override public var bounds: CGRect {
        didSet {
            if bounds.size != oldValue.size {
                view_bounds()
            }
        }
    }
    
    /** 大小变化 */
    public func view_bounds() {
        select.corner = select.bounds.width / 2
    }
    
}
