//
//  Ex_CGRect.swift
//  Days3
//
//  Created by 黄穆斌 on 2018/7/31.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension CGRect {
    
    /** 修改高度 */
    public func height(_ value: CGFloat) -> CGRect {
        var rect = self
        rect.size.height += value
        return rect
    }
    
}
