//
//  Ex_UITextView.swift
//  My
//
//  Created by Myron on 2018/4/20.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

extension UITextView {
    
    /** 用于检测字符串高度的对象 */
    public static let view: UITextView = UITextView(frame: CGRect.zero)
    
    public static func height(s: String, w: CGFloat) -> CGFloat {
        view.text = s
        view.sizeThatFits(CGSize(width: w, height: 3))
        return view.bounds.height
    }
    
}
