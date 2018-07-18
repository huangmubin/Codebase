//
//  Hint_Content_Label.swift
//  HuaChuang
//
//  Created by Myron on 2018/7/18.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension Hint {
    
    public class Content_Label: Hint.Content {
        
        public override func view_deploy() {
            super.view_deploy()
            label.textColor = color
            label.numberOfLines = 0
            label.textAlignment = .center
            addSubview(label)
        }
        
        public override func view_bounds() {
            super.view_bounds()
            label.frame = bounds
        }
        
        // MARK: - Sub View
        
        public var label: UILabel = UILabel()
        public var color: UIColor = UIColor.black
        
    }
    
}
