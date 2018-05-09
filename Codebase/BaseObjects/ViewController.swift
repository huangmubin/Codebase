//
//  ViewController.swift
//  TestSwift
//
//  Created by Myron on 2018/4/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

/**
 扩展 UIViewController
 提供各种常用功能
 */
public class ViewController: UIViewController {
    
    // MARK: - View Life
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(orientation_will_change),
            name: .UIApplicationWillChangeStatusBarOrientation,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(orientation_changed),
            name: .UIApplicationDidChangeStatusBarOrientation,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboard_will_change_frame(_:)),
            name: .UIKeyboardWillChangeFrame,
            object: nil
        )
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch (supportedInterfaceOrientations, UIDevice.current.orientation) {
        case (.all, _):
            break
        case (.portrait, .landscapeLeft), (.portrait, .landscapeRight):
            UIDevice.current.setValue(
                UIInterfaceOrientation.portrait.rawValue,
                forKey: "orientation"
            )
            UIApplication.shared.statusBarOrientation = .portrait
        case (.landscape, .portrait):
            UIDevice.current.setValue(
                UIInterfaceOrientation.landscapeLeft.rawValue,
                forKey: "orientation"
            )
            UIApplication.shared.statusBarOrientation = .landscapeLeft
        default:
            break
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Orientation supporet
    
    /*
     override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
     return UIInterfaceOrientationMask.all
     }
     */
    
    // MARK: - Status bar
    
    /*
     override var prefersStatusBarHidden: Bool {
     return false
     }
     */
    
    // MARK: - Orientation Observer
    
    @objc private func orientation_changed() {
        DispatchQueue.main.async {
            self.orientation_changed_action()
        }
    }
    
    @objc private func orientation_will_change() {
        DispatchQueue.main.async {
            self.orientation_will_change_action()
        }
    }
    
    /** Override: Call when orientation changed at main queue */
    public func orientation_changed_action() { }
    
    /** Override: Call when orientation will change at main queue */
    public func orientation_will_change_action() { }
    
    // MARK: - Keyboard Observer
    
    @objc func keyboard_will_change_frame(_ notification: Notification) {
        if let info = notification.userInfo {
            if let rect = info[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                self.keyboard_will_change_frame(keyboard: rect.cgRectValue)
            }
        }
    }
    
    /** keyboard will change to the new rect */
    public func keyboard_will_change_frame(keyboard rect: CGRect) { }
    
    // MARK: - Transport The Data
    
    /** Messages from other controller */
    public var messages: [String: Any] = [:]
    
    /** Send message to the Super Controller (presentingViewController) */
    public func toSuperController(object: [String: Any]) {
        // Normal
        if let controller = self.presentingViewController as? ViewController {
            for (key, value) in object {
                controller.messages[key] = value
            }
        }
        // Navigation controller
        if let navigation = self.navigationController {
            if let index = navigation.viewControllers.index(of: self) {
                if index - 1 > 0 {
                    if let controller = navigation.viewControllers[index-1] as? ViewController {
                        for (key, value) in object {
                            controller.messages[key] = value
                        }
                    }
                }
            }
        }
        // Tabbar's Sub controller
        if let tabbar = self.presentingViewController as? UITabBarController {
            if let controller = tabbar.selectedViewController as? ViewController {
                for (key, value) in object {
                    controller.messages[key] = value
                }
            }
            if let navigation = tabbar.selectedViewController as? UINavigationController {
                if let controller = navigation.viewControllers.last as? ViewController {
                    for (key, value) in object {
                        controller.messages[key] = value
                    }
                }
            }
        }
    }
    
    /** Analysis message, if have value, call controller_message */
    public func analysis_messages() {
        for (key, value) in messages {
            controller_message(key: key, value: value)
        }
        messages.removeAll()
    }
    
    /** Override: Call when analysis messages function have value */
    public func controller_message(key: String, value: Any) { }
    
}

// MARK: - Tools

extension ViewController {
    
    /** 当前屏幕最顶部的控制器 */
    public class func top() -> UIViewController? {
        func top(controller: UIViewController) -> UIViewController? {
            if let navigation = controller as? UINavigationController {
                return navigation.topViewController
            } else if let tabbar = controller as? UITabBarController {
                return tabbar.selectedViewController
            } else {
                return controller
            }
        }
        
        var top_controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        while top_controller?.presentedViewController != nil {
            top_controller = top(controller: top_controller!.presentedViewController!)
        }
        return top_controller
    }

}
