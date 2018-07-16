//
//  Hint_Teletext.swift
//  HuaChuang
//
//  Created by Myron on 2018/7/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension Hint {
    
    public class Teletext: Hint.Auto {
        
        // MARK: - Sub
        
        public var info: UILabel = UILabel()
        
        public var image: UIImageView = UIImageView(image: nil)
        
        public var image_size: CGSize = CGSize(width: 30, height: 30)
        
        // MARK: - Deploy
        
        public override func view_deploy() {
            super.view_deploy()
            addSubview(image)
            addSubview(info)
            info.numberOfLines = 0
        }
        
        // MARK: - Bounds
        
        public override func view_bounds() {
            super.view_bounds()
            image.frame = CGRect(
                x: (bounds.width - image_size.width) / 2,
                y: edge.top,
                width: image_size.width,
                height: image_size.height
            )
            info.frame.origin = CGPoint(
                x: (bounds.width - info.bounds.width) / 2,
                y: image.frame.maxY + space
            )
        }
        
        // MARK: - Value
        
        /** [UIImage, String] */
        public override func update(_ value: Any) {
            if let values = value as? [Any] {
                image.image = values.first as? UIImage
                info.text = values.last as? String
            }
            
            let screen_size = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 0.5
            var limit: CGFloat = max(100, image_size.width)
            
            var size: CGSize = CGSize.zero
            repeat {
                limit += 20
                info.frame = CGRect(
                    origin: CGPoint.zero,
                    size: CGSize(width: limit, height: limit)
                )
                info.sizeToFit()
                
                size = CGSize(
                    width: limit + edge.left + edge.right,
                    height: image_size.height + space + info.frame.height + edge.top + edge.bottom
                )
            } while limit <= screen_size && size.width < size.height
            
            rect_show = CGRect(
                x: (UIScreen.main.bounds.width - size.width) / 2,
                y: (UIScreen.main.bounds.height - size.height) / 2,
                width: size.width,
                height: size.height
            )
            rect_hide = CGRect(
                x: rect_show.minX + 40,
                y: rect_show.minY + 40,
                width: rect_show.width - 80,
                height: rect_show.height - 80
            )
        }
        
        
        // MARK: - Push
        
        /**  */
        public override func push_animation() {
            super.push_animation()
            self.info.alpha = 0
            UIView.animate(withDuration: push_animation_time, delay: push_animation_time * 0.4, options: UIViewAnimationOptions.curveLinear, animations: {
                self.info.alpha = 1
            }, completion: nil)
        }
        
        // MARK: - Close
        
        /**  */
        public override func close_animation() {
            super.close_animation()
            UIView.animate(withDuration: close_animation_time / 2, animations: {
                self.image.alpha = 0
                self.info.alpha = 0
            })
        }
        
    }
    
}
