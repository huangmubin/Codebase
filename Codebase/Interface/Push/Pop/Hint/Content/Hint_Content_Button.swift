//
//  Hint_Content_Button.swift
//  HuaChuang
//
//  Created by Myron on 2018/7/18.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension Hint {
    
    public class Content_Button: Hint.Content {
        
        public override func view_deploy() {
            super.view_deploy()
            addSubview(button)
            button.addTarget(self, action: #selector(button_action), for: .touchUpInside)
            button.tintColor = color
        }
        
        public override func view_bounds() {
            super.view_bounds()
            button.frame = bounds
        }
        
        // MARK: - Sub View
        
        public var button: UIButton = UIButton(type: UIButtonType.system)
        public var color: UIColor = UIColor.black
        
        weak var hint: Hint.Hand?
        @objc func button_action() {
            hint?.content_action(self, value: button)
        }
        
    }
    
}
