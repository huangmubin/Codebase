//
//  Notifiable.swift
//  TestSwift
//
//  Created by Myron on 2018/4/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import Foundation

/** 为对象提供简易的通知相关方法 */
public protocol Notifiable { }

// MARK: - Observer

extension Notifiable {
    
    /** 添加监听 */
    public func observer(name: Notification.Name, selector: Selector, object: Any? = nil) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: object)
    }
    /** 添加监听 */
    public func observer(name: Notification.Name, object: Any? = nil, queue: OperationQueue? = nil, using: @escaping (Notification) -> Void) {
        NotificationCenter.default.addObserver(forName: name, object: object, queue: queue, using: using)
    }
    
}

// MAKR: - Unobserver

extension Notifiable {
    
    /** 移除监听 */
    public func unobserver(name: NSNotification.Name? = nil, object: Any? = nil) {
        NotificationCenter.default.removeObserver(self, name: name, object: object)
    }
    
}

// MARK: - Post

extension Notifiable {
    
    /** 发送消息 */
    public func post(name: NSNotification.Name, infos: [AnyHashable: Any]? = nil) {
        NotificationCenter.default.post(name: name, object: self, userInfo: infos)
    }
    
    /** Post a notify in specific queue. */
    public func post(name: NSNotification.Name, infos: [AnyHashable: Any]? = nil, queue: DispatchQueue) {
        queue.async {
            NotificationCenter.default.post(name: name, object: self, userInfo: infos)
        }
    }
    
}

// MARK: - Extension String

extension String {
    
    /**  */
    var notify: Notification.Name {
        return Notification.Name.init(self)
    }
    
}
