//
//  Hint_Content_Error.swift
//  HuaChuang
//
//  Created by Myron on 2018/7/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension Hint {
    
    public class Content_Indicator: Hint.Content {
        
        public override func view_deploy() {
            super.view_deploy()
            indicator.color = color
            indicator.hidesWhenStopped = false
            addSubview(indicator)
        }
        
        public override func view_bounds() {
            super.view_bounds()
            indicator.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        }
        
        // MARK: - Sub View
        
        public var indicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        
        public var color: UIColor = UIColor.black
        
        // MARK: - Run
        
        public override func run() {
            indicator.startAnimating()
        }
        
    }
    
}
