//
//  Hint_Animation.swift
//  HuaChuang
//
//  Created by Myron on 2018/7/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension Hint {
    
    public class Animation: Hint.Hand {
        
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
            let size = content?.size ?? CGSize(width: 40, height: 40)
            
            let c_frame = CGRect(
                x: (bounds.width - size.width) / 2,
                y: edge.top,
                width: size.width,
                height: size.height
            )
        
            content?.frame = c_frame
            
            info.frame.origin = CGPoint(
                x: (bounds.width - info.frame.width) / 2,
                y: c_frame.maxY + space
            )
        }
        
        // MARK: - Value
        
        public override func update(_ value: Any) {
            info.text = value as? String
            
            let screen_size = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 0.5
            var limit: CGFloat = 100
            let content_size = content?.size ?? CGSize(width: 40, height: 40)
            
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
                    height: content_size.height + space + info.frame.height + edge.top + edge.bottom
                )
            } while limit <= screen_size && size.width < size.height
            
            rect_show = CGRect(
                x: (UIScreen.main.bounds.width - size.width) / 2,
                y: (UIScreen.main.bounds.height - size.height) / 2,
                width: size.width,
                height: size.height
            )
            rect_hide_default()
        }
        
        // MARK: - Push
        
        public override func push_animation_end() {
            DispatchQueue.main.delay(time: max(content?.animate_time ?? 0, 2), execute: {
                self.close()
            })
        }
        
        // MARK: - Close
        
        /**  */
        public override func close_animation() {
            super.close_animation()
            UIView.animate(withDuration: close_animation_time / 2, animations: {
                self.info.alpha = 0
            }, completion: { _ in
                self.content?.stop()
            })
        }
        
        // MARK: - Default
        
        convenience init(success value: String) {
            self.init()
            self.deploy(content: Hint.Content_Success())
            self.update(value)
        }
        
        convenience init(error value: String) {
            self.init()
            self.deploy(content: Hint.Content_Error())
            self.update(value)
        }
        
    }
    
}
