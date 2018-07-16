//
//  Hint_Info.swift
//  HuaChuang
//
//  Created by Myron on 2018/7/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension Hint {
    
    public class Info: Hint.Auto {
        
        // MARK: - Sub
        
        public var info: UILabel = UILabel()
        
        // MARK: - Deploy
        
        public override func view_deploy() {
            super.view_deploy()
            
            addSubview(info)
            info.numberOfLines = 0
        }
        
        // MARK: - Bounds
        
        public override func view_bounds() {
            super.view_bounds()
            info.center = CGPoint(
                x: bounds.width / 2,
                y: bounds.height / 2
            )
        }
        
        // MARK: - Value
        
        public override func update(_ value: Any) {
            info.text = value as? String
            
            let screen_size = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 0.5
            var limit: CGFloat = 60
            
            repeat {
                limit += 20
                info.frame = CGRect(
                    origin: CGPoint.zero,
                    size: CGSize(width: limit, height: limit)
                )
                info.sizeToFit()
            } while limit <= screen_size && info.frame.width < info.frame.height
            
            rect_show = CGRect(
                x: (UIScreen.main.bounds.width - limit - edge.left) / 2,
                y: (UIScreen.main.bounds.height - limit - edge.top) / 2,
                width: limit + edge.left + edge.right,
                height: limit + edge.top + edge.bottom
            )
            rect_hide = CGRect(
                x: rect_show.minX + 40,
                y: rect_show.minY + 40,
                width: rect_show.width - 80,
                height: rect_show.height - 80
            )
        }
//        
//        
//        // MARK: - Push
//        
//        /**  */
//        public override func push_animation() {
//            self.frame = self.rect_hide
//            self.alpha = 0
//            UIView.animate(withDuration: push_animation_time, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
//                self.frame = self.rect_show
//                self.alpha = 1
//            }, completion: nil)
//        }
        
        // MARK: - Close
        
        /**  */
        public override func close_animation() {
            super.close_animation()
            UIView.animate(withDuration: close_animation_time / 2, animations: {
                self.info.alpha = 0
            })
        }
        
        
    }
    
}
