//
//  CalendarUnitViews.swift
//  Days
//
//  Created by Myron on 2018/6/22.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

// MARK: - Week

extension CalendarView {
    
    /** 日，一，二，三，四，五，六 */
    public class Week: View {
        
        /** Link to Calendar View */
        weak var calendar: CalendarView?
        
        // MARK: - Value
        
        /**  */
        public var font: UIFont = UIFont(name: "PingFangSC-Regular", size: 18)!
        /**  */
        public var color: UIColor = UIColor(160,160,160,1)
        
        /**  */
        public var values: [String] = ["日", "一", "二", "三", "四", "五", "六", ]
        /**  */
        public var labels: [UILabel] = []
        
        // MARK: - Function
        
        /** Update the color and font */
        public func update() {
            for label in labels {
                label.textColor = color
                label.font = font
            }
        }
        
        /** reload all views */
        public func reload() {
            labels.forEach({ $0.removeFromSuperview() })
            labels.removeAll()
            for day in values {
                let label = UILabel()
                label.textColor = color
                label.font = font
                label.textAlignment = .center
                label.text = day
                labels.append(label)
                addSubview(label)
            }
            view_bounds()
        }
        
        // MARK: - Views
        
        /**  */
        public override func view_deploy() {
            super.view_deploy()
            reload()
        }
        
        public override func view_bounds() {
            super.view_bounds()
            let w = bounds.width / CGFloat(labels.count)
            for (i, label) in labels.enumerated() {
                label.frame = CGRect(
                    x: CGFloat(i) * w, y: 0,
                    width: w, height: bounds.height
                )
            }
        }
        
    }
    
}
