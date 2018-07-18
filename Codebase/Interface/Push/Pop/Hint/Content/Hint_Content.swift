//
//  Hint_Content.swift
//  HuaChuang
//
//  Created by Myron on 2018/7/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension Hint {
    
    public class Content: View {
        
        public var size: CGSize = CGSize(width: 40, height: 40)
        
        /***/
        public var animate_time: TimeInterval = 2
        
        /** Override: 启动动画 */
        public func run() {}
        /** Override: 关闭动画 */
        public func stop() {}
        /** Override: 清空内存 */
        public func clear() {}
        
        /** Override: 更新进度内容 */
        public func progress(_ value: CGFloat) {}
        
    }
    
}
