//
//  Ex_UIView.swift
//  Days3
//
//  Created by 黄穆斌 on 2018/7/31.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension UIView {
    
    /** Get the frame in super */
    func frame(in view: UIView) -> CGRect {
        var super_view = self.superview
        var rect = self.frame
        while super_view != nil && super_view !== view {
            if let scroll = super_view as? UIScrollView {
                rect = rect.offsetBy(dx: scroll.contentOffset.x, dy: scroll.contentOffset.y)
            }
            rect = rect.offsetBy(dx: super_view!.frame.minX, dy: super_view!.frame.minY)
            super_view = super_view?.superview
        }
        return rect
    }
    
}
