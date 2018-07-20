//
//  CustemPop.swift
//  HuaChuang
//
//  Created by Myron on 2018/7/19.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

/**  */
public class CustomPop: PushView {
    
    // MARK: - Sub Views
    
    /** 子视图 */
    public var subs: [CustomSub] = []
    
    // MARK: - Deploy
    
    public override func view_deploy() {
        super.view_deploy()
    }
    
    // MARK: - View Bounds
    
    public override func view_bounds() {
        super.view_bounds()
        
    }
    
    // MARK: - Rect
    
    // MARK: - Animation
    
    public struct Animation {
        public struct Time {
            public var show: TimeInterval = 1
            public var hide: TimeInterval = 1
            init() {}
        }
        
        public var show: CGRect = CGRect.zero
        public var hide: CGRect = CGRect.zero
        public var time: Time = Time()
        init() {}
    }
    
    /** 大小 */
    public var animate: Animation = Animation()
    
    /** 自动根据 Animation Show 缩放 Rect Hide */
    public func deploy_rect(hide size: CGFloat) {
        animate.hide = CGRect(
            x: animate.show.minX + size,
            y: animate.show.minY + size,
            width: animate.show.width - size * 2,
            height: animate.show.height - size * 2
        )
    }
    
    /** Animation */
    public func push_animation() {
        frame = animate.show
        alpha = 0
        UIView.animate(withDuration: animate.time.show, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.frame = self.animate.show
            self.alpha = 1
        }, completion: { _ in
            self.push_animation_completion()
        })
    }
    
    /**  */
    public func push_animation_completion() {}
    
    /**  */
    public func close_animation() {
        UIView.animate(withDuration: animate.time.hide, animations: {
            self.frame = self.animate.hide
            self.alpha = 0
        }, completion: { _ in
            self.close_animation_completion()
        })
    }
    
    /**  */
    public func close_animation_completion() {}
    
}
