//
//  Hint.swift
//  HuaChuang
//
//  Created by Myron on 2018/7/14.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

public class Hint: PushView {
    
    public override func view_deploy() {
        super.view_deploy()
        clipsToBounds = true
        
        key_window.backgroundColor = UIColor.clear
        
        rect_hide = CGRect(
            x: (UIScreen.main.bounds.width - 20) / 2,
            y: (UIScreen.main.bounds.height - 20) / 2,
            width: 20,
            height: 20
        )
        let w = UIScreen.main.bounds.width * 0.4
        rect_show = CGRect(
            x: (UIScreen.main.bounds.width - w) / 2,
            y: (UIScreen.main.bounds.height - w) / 2,
            width: w, height: w
        )
        
        addSubview(back)
    }
    
    // MARK: - Progress
    
    /**  */
    public var progress: CGFloat = 1
    /**  */
    public func update(progress value: CGFloat) {
        progress = value
    }
    
    // MARK: - Bounds
    
    /**  */
    public var rect_show: CGRect = CGRect.zero
    /**  */
    public var rect_hide: CGRect = CGRect.zero
    
    /** 四周的空间 */
    public var edge: UIEdgeInsets = UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20)
    
    /** 两个内容视图之间的空间 */
    public var space: CGFloat = 20
    
    /**  */
    public override func view_bounds() {
        super.view_bounds()
        back.frame = bounds
    }
    
    // MARK: - Back
    
    /**  */
    public let back: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        return view
    }()
    
    // MARK: - Push
    
    /**  */
    public static var showing: Hint?
    /**  */
    public var push_animation_time: TimeInterval = 1
    
    /**  */
    public override func push() {
        super.push()
        if let show = Hint.showing {
            show.close()
        }
        Hint.showing = self
        push_animation()
    }
    
    /**  */
    public func push_animation() {
        self.frame = self.rect_hide
        self.alpha = 0
        UIView.animate(withDuration: push_animation_time, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.frame = self.rect_show
            self.alpha = 1
        }, completion: nil)
    }
    
    // MARK: - Close
    
    /**  */
    public var close_animation_time: TimeInterval = 1
    
    /**  */
    public override func close() {
        if Hint.showing === self {
            Hint.showing = nil
        }
        close_animation()
    }
    
    /**  */
    public func close_animation() {
        UIView.animate(withDuration: close_animation_time, animations: {
            self.frame = self.rect_hide
            self.alpha = 0
        }, completion: { _ in
            self.clear()
        })
    }
    
}
