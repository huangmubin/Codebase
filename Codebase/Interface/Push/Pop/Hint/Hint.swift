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
    
    /**  */
    public override func view_bounds() {
        super.view_bounds()
        
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
            show.dismiss()
        }
        Hint.showing = self
        push_animation()
    }
    
    /**  */
    public func push_animation() {
        UIView.animate(withDuration: push_animation_time, animations: {
            self.frame = self.rect_show
        }, completion: { _ in
            self.push_ended()
        })
    }
    
    /**  */
    public func push_ended() { }
    
    // MARK: - Dismiss
    
    /**  */
    public var dismiss_animation_time: TimeInterval = 1
    
    /**  */
    public func dismiss() {
        dismiss_animation()
    }
    
    /**  */
    public func dismiss_animation() {
        UIView.animate(withDuration: dismiss_animation_time, animations: {
            self.frame = self.rect_hide
        }, completion: { _ in
            self.dismiss_ended()
            if Hint.showing === self {
                Hint.showing = nil
            }
            self.removeFromSuperview()
            self.key_window.isHidden = true
        })
    }
    
    /**  */
    public func dismiss_ended() { }
    
}
