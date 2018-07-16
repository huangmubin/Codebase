//
//  Hint_Hand.swift
//  HuaChuang
//
//  Created by Myron on 2018/7/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension Hint {
    
    public class Hand: Hint {
        
        // MARK: - Sub
        
        public var content: Hint.Content?
        
        // MARK: - Deploy
        
        public override func view_deploy() {
            super.view_deploy()
            push_animation_time = 0.5
            close_animation_time = 0.5
        }
        
        // MARK: - Push
        
        /**  */
        public override func push() {
            super.push()
            content?.run()
        }
        
        // MARK: - Tap
        
        public override func tap_action(_ sender: UITapGestureRecognizer) { }
        
    }
    
}
