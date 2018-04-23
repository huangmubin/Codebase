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
    
    /** 获取 View 的尺寸 */
    public static func height(size: CGSize) -> CGFloat {
        return UITextView.view.sizeThatFits(size).height
    }
    
    /** 快捷设置属性并获取高度 */
    public static func height(text: String, font: UIFont? = nil, size: CGSize) -> CGFloat {
        view.text = text
        if let f = font {
            view.font = f
        }
        return UITextView.view.sizeThatFits(size).height
    }
    
}
