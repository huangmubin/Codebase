//
//  Hint_Content_DLabel.swift
//  HuaChuang
//
//  Created by Myron on 2018/7/18.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension Hint {
    
    public class Content_Infos: Hint.Content {
        
        public override func view_deploy() {
            super.view_deploy()
            for label in [left, right] {
                label.textColor = color
                label.numberOfLines = 0
                addSubview(label)
            }
            left.textAlignment = .left
            right.textAlignment = .right
        }
        
        public override func view_bounds() {
            super.view_bounds()
            let w = bounds.width * ratio
            left.frame = CGRect(
                x: 0, y: 0,
                width: w, height: bounds.height
            )
            right.frame = CGRect(
                x: left.frame.maxX + 4,
                y: left.frame.minY,
                width: bounds.width - left.frame.maxX - 4,
                height: left.frame.height
            )
        }
        
        // MARK: - Sub View
        
        public var left: UILabel = UILabel()
        public var right: UILabel = UILabel()
        public var color: UIColor = UIColor.black
        /** left.width in bounds.width */
        public var ratio: CGFloat = 0.8
        
    }
    
}
