//
//  Ex_UIFont.swift
//  Days3
//
//  Created by Myron on 2018/7/27.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension UIFont {
    
    public enum Width: String {
        /** 极细体 */
        case ultralight = "Ultralight"
        /** 纤细体 */
        case thin = "Thin"
        /** 细体 */
        case light = "Light"
        /** 常规体 */
        case regular = "Regular"
        /** 中黑体 */
        case medium = "Medium"
        /** 中粗体 */
        case semibold = "Semibold"
    }
    
    public class func PingFangSC(_ width: Width, size: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-" + width.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
}
