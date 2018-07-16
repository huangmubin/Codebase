//
//  Hint_Indicator.swift
//  HuaChuang
//
//  Created by Myron on 2018/7/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension Hint {
    
    public class Indicator: Hint.Hand {
        
        // MARK: - Sub
        
        public var indicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        
        public var info: UILabel = UILabel()
        
        // MARK: - Deploy
        
        public override func view_deploy() {
            super.view_deploy()
            addSubview(indicator)
            indicator.hidesWhenStopped = false
            indicator.color = UIColor.black
            
            addSubview(info)
            info.numberOfLines = 0
        }
        
        // MARK: - Bounds
        
        public override func view_bounds() {
            super.view_bounds()
            indicator.center = CGPoint(
                x: bounds.width / 2,
                y: edge.top + indicator.bounds.height / 2
            )
            info.frame.origin = CGPoint(
                x: (bounds.width - info.frame.width) / 2,
                y: indicator.frame.maxY + space
            )
        }
        
        // MARK: - Value
        
        public override func update(_ value: Any) {
            info.text = value as? String
            
            let screen_size = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 0.5
            var limit: CGFloat = 100
            
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
                    height: indicator.frame.height + space + info.frame.height + edge.top + edge.bottom
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
        
        public override func push() {
            super.push()
            indicator.startAnimating()
        }
        
        // MARK: - Close
        
        /**  */
        public override func close_animation() {
            super.close_animation()
            indicator.stopAnimating()
            UIView.animate(withDuration: close_animation_time / 2, animations: {
                self.info.alpha = 0
            })
        }
        
        public override func tap_action(_ sender: UITapGestureRecognizer) {
            self.close()
        }
    }
    
}
