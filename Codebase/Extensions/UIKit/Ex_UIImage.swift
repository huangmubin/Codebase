//
//  Ex_UIImage.swift
//  Days
//
//  Created by Myron on 2018/5/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension UIImage {
    
    // MARK: - 修改颜色
    
    /** 修改颜色
     出处: https://onevcat.com/2013/04/using-blending-in-ios/
     */
    public func change(color: UIColor, model: CGBlendMode = CGBlendMode.overlay) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        let bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIRectFill(bounds)
        
        draw(in: bounds, blendMode: model, alpha: 1)
        
        if model != CGBlendMode.destinationIn {
            self.draw(in: bounds, blendMode: .destinationIn, alpha: 1)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
