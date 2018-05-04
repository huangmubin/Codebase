//
//  Ex_UITextField.swift
//  My
//
//  Created by Myron on 2018/5/4.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

extension UITextField {
    
    /** 用于检测字符串高度的对象 */
    public static let view: UITextField = {
        let v = UITextField(frame: CGRect.zero)
        v.adjustsFontSizeToFitWidth = false
        return v
    }()
    
    /** 获取 View 的尺寸 */
    public static func height(size: CGSize) -> CGFloat {
        return UITextField.view.sizeThatFits(size).height
    }
    
    /** 快捷设置属性并获取高度 */
    public static func height(text: String, font: UIFont? = nil, size: CGSize) -> CGFloat {
        view.text = text
        if let f = font {
            view.font = f
        }
        return UITextField.view.sizeThatFits(size).height
    }
    
}
