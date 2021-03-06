//
//  PushView.swift
//  Days
//
//  Created by 黄穆斌 on 2018/5/27.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

/** 初始化后，必须调用 push() */
public class PushView: View, TimerDelegate {
    
    // MARK: - View Deploy
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        //print("PushView is deinit")
    }
    
    public override func view_deploy() {
        //print("PushView is view deploy.")
        
        key_window.rootViewController = UIViewController()
        key_window.rootViewController?.view.isUserInteractionEnabled = false
        
        key_window.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        key_window.windowLevel = UIWindowLevelStatusBar
        key_window.alpha = 1
        key_window.addSubview(self)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(tap_action(_:)))
        key_window.addGestureRecognizer(tap)
        
        timer = Timer(delegate: self)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboard_will_change_frame(_:)),
            name: .UIKeyboardWillChangeFrame,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(status_bar_orientation_will_change(_:)),
            name: .UIApplicationWillChangeStatusBarOrientation,
            object: nil
        )
    }
    
    // MARK: - Interface
    
    /** Override: Call when keyboard change, before open and close */
    public func keyboard_change(rect: CGRect) { }
    
    /** Override: Call when keyboard open */
    public func keyboard_open(rect: CGRect) { }
    
    /** Override: Call when keyboard close */
    public func keyboard_close(rect: CGRect) { }
    
    /** Override: Call when keyboard close */
    public func orientation_changed(rect: CGRect) { }
    
    // MARK: - Data
    
    /** 识别 id */
    public var id: String = ""
    
    // MARK: - Window
    
    /** 背景视窗 */
    public var key_window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
    
    // MARK: - Orientaion
    
    @objc func status_bar_orientation_will_change(_ notification: Notification) {
        let i = notification.userInfo!["UIApplicationStatusBarOrientationUserInfoKey"] as! Int
        var rect: CGRect
        switch UIDeviceOrientation(rawValue: i)! {
        case .faceDown, .faceUp, .portrait, .portraitUpsideDown, .unknown:
            rect = CGRect(
                x: 0, y: 0,
                width: min(UIScreen.main.bounds.width, UIScreen.main.bounds.height),
                height: max(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
            )
        case .landscapeLeft, .landscapeRight:
            rect = CGRect(
                x: 0, y: 0,
                width: max(UIScreen.main.bounds.width, UIScreen.main.bounds.height),
                height: min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
            )
        }
        orientation_changed(rect: rect)
    }
    
    // MARK: - Keyboard Observer
    
    @objc func keyboard_will_change_frame(_ notification: Notification) {
        if let info = notification.userInfo {
            if let rect = info[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                self.keyboard_will_change_frame(keyboard: rect.cgRectValue)
            }
        }
    }
    
    /** Temp value */
    public var keyboard_minY: CGFloat = 0
    /** keyboard will change to the new rect */
    public func keyboard_will_change_frame(keyboard rect: CGRect) {
        keyboard_minY = rect.minY
        keyboard_change(rect: rect)
        if rect.minY < UIScreen.main.bounds.height {
            keyboard_open(rect: rect)
        } else {
            keyboard_close(rect: rect)
        }
    }
    
    // MARK: - Timer
    
    public var timer: Timer!
    
    public func timer_update(total: Int, time: Int, interval: DispatchTimeInterval) { }
    public func timer_finish(total: Int, time: Int, interval: DispatchTimeInterval) { }
    
    // MARK: - Gesture
    
    public var tap: UITapGestureRecognizer!
    
    /** 点击触摸时间，默认为关闭 */
    @objc public func tap_action(_ sender: UITapGestureRecognizer) {
        close()
    }
    
    // MARK: - Action
    
    /** 弹出窗口 */
    public func push() {
        key_window.makeKeyAndVisible()
    }
    
    public func push(value: Any) {
        update(value)
        push()
    }
    
    /** 关闭窗口 */
    public func close() {
        clear()
    }
    
    /** 关闭窗口 */
    public func clear() {
        removeFromSuperview()
        key_window.isHidden = true
        timer?.clear()
        timer = nil
    }
    
    /** 传输数据 */
    public func update(_ value: Any) { }
    
}
