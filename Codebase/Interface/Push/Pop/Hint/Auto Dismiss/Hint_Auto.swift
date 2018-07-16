//
//  Hint_Auto.swift
//  HuaChuang
//
//  Created by Myron on 2018/7/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension Hint {
    
    public class Auto: Hint {
        
        public override func view_deploy() {
            super.view_deploy()
            push_animation_time = 0.5
            close_animation_time = 0.5
        }
        
        // MARK: - Push
        
        /**  */
        public override func push() {
            super.push()
            timer.run(second: auto_close_time)
        }
        
        public func push(time: Int) {
            auto_close_time = time
            push()
        }
        
        // MARK: - Timer
        
        /** 自动关闭时间 */
        public var auto_close_time: Int = 3
        
        /** */
        public override func timer_finish(total: Int, time: Int, interval: DispatchTimeInterval) {
            close()
        }
        
    }
    
}
