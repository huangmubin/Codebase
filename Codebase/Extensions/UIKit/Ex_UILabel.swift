//
//  Ex_UILabel.swift
//  My
//
//  Created by Myron on 2018/4/23.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

extension UILabel {
    
    /** 用于检测字符串高度的对象 */
    public static let view: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.numberOfLines = 0
        return label
    }()
    
    /** 获取 View 的尺寸 */
    public static func height(size: CGSize) -> CGFloat {
        return UILabel.view.sizeThatFits(size).height
    }
    
    /** 快捷设置属性并获取高度 */
    public static func height(text: String, font: UIFont? = nil, size: CGSize) -> CGFloat {
        UILabel.view.text = text
        if let f = font {
            UILabel.view.font = f
        }
        return UILabel.view.sizeThatFits(size).height
    }
    
}
