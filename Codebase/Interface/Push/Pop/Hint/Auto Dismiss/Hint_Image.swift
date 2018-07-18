//
//  Hint_Image.swift
//  HuaChuang
//
//  Created by Myron on 2018/7/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension Hint {
    
    public class Image: Hint.Auto {
        
        // MARK: - Sub
        
        public var image: UIImageView = UIImageView(image: nil)
        
        public var image_size: CGSize = CGSize(width: 30, height: 30)
        
        // MARK: - Deploy
        
        public override func view_deploy() {
            super.view_deploy()
            addSubview(image)
        }
        
        // MARK: - Bounds
        
        public override func view_bounds() {
            super.view_bounds()
            image.frame = CGRect(
                x: edge.left, y: edge.top,
                width: bounds.width - edge.left - edge.right,
                height: bounds.height - edge.top - edge.bottom
            )
        }
        
        // MARK: - Value
        
        public override func update(_ value: Any) {
            image.image = value as? UIImage
            
            rect_show = CGRect(
                x: (UIScreen.main.bounds.width - image_size.width - edge.left) / 2,
                y: (UIScreen.main.bounds.height - image_size.height - edge.top) / 2,
                width: image_size.width + edge.left + edge.right,
                height: image_size.height + edge.top + edge.bottom
            )
            rect_hide_default()
        }
        
        // MARK: - Close
        
        /**  */
        public override func close_animation() {
            super.close_animation()
            UIView.animate(withDuration: close_animation_time / 2, animations: {
                self.image.alpha = 0
            })
        }
        
        // MARK: - Cache
        
        public class Cache {
            static var _success: UIImage?
            static var success: UIImage {
                if let image = _success {
                    return image
                } else {
                    UIGraphicsBeginImageContextWithOptions(CGSize(width: 36, height: 36), false, 0)
                    
                    let path = UIBezierPath()
                    path.move(to: CGPoint(x: 10, y: 18))
                    path.addLine(to: CGPoint(x: 16, y: 24))
                    path.addLine(to: CGPoint(x: 27, y: 13))
                    path.move(to: CGPoint(x: 10, y: 18))
                    path.close()
                    
                    UIColor.black.setStroke()
                    path.stroke()
                    
                    _success = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                    return _success!
                }
            }
            
            static var _error: UIImage?
            static var error: UIImage {
                if let image = _error {
                    return image
                } else {
                    UIGraphicsBeginImageContextWithOptions(CGSize(width: 36, height: 36), false, 0)
                    
                    let path = UIBezierPath()
                    path.move(to: CGPoint(x: 10, y: 10))
                    path.addLine(to: CGPoint(x: 26, y: 26))
                    path.move(to: CGPoint(x: 10, y: 26))
                    path.addLine(to: CGPoint(x: 26, y: 10))
                    path.move(to: CGPoint(x: 10, y: 10))
                    path.close()
                    
                    UIColor.black.setStroke()
                    path.stroke()
                    
                    _error = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                    return _error!
                }
            }
        }
    }
}
