//
//  View.swift
//  TestSwift
//
//  Created by Myron on 2018/4/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

/**
 扩展 UIView
 提供各种常用功能
 */
public class View: UIView {
    
    // MARK: - Storyboard
    
    // MARK: 圆角控制
    
    /**  */
    @IBInspectable public var corner: CGFloat = 0 {
        didSet { self.layer.cornerRadius = corner }
    }
    
    // MARK: 边框控制
    
    /**  */
    @IBInspectable public var border_color: UIColor? = nil {
        didSet { self.layer.borderColor = border_color?.cgColor }
    }
    
    /**  */
    @IBInspectable public var border: CGFloat = 0 {
        didSet { self.layer.borderWidth = border }
    }
    
    // MARK: - 阴影控制
    
    /**  */
    @IBInspectable public var shadow_opacity: Float = 0 {
        didSet { layer.shadowOpacity = shadow_opacity }
    }
    
    /**  */
    @IBInspectable public var shadow_radius: CGFloat = 0 {
        didSet { layer.shadowRadius = shadow_radius }
    }
    
    /**  */
    @IBInspectable public var shadow_offset: CGPoint = CGPoint.zero {
        didSet { layer.shadowOffset = CGSize(width: shadow_offset.x, height: shadow_offset.y) }
    }
    
    /**  */
    @IBInspectable public var shadow_color: UIColor? = nil {
        didSet { layer.shadowColor = shadow_color?.cgColor }
    }
    
    // MARK: - Init
    
    init() {
        super.init(frame: CGRect.zero)
        view_deploy()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        view_deploy()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view_deploy()
    }
    
    /** 初始化 */
    public func view_deploy() { }
    
    // MARK: - Size
    
    override public var frame: CGRect {
        didSet{
            if frame.size != oldValue.size {
                view_bounds()
            }
        }
    }
    override public var bounds: CGRect {
        didSet {
            if bounds.size != oldValue.size {
                view_bounds()
            }
        }
    }
    
    /** 大小变化 */
    public func view_bounds() { }
    
    // MARK: - Controller
    
    /** 获取自身的 Controller */
    public func controller() -> UIViewController? {
        var reponder: UIResponder? = self.next
        while reponder != nil {
            if let c = next as? UIViewController {
                return c
            }
            reponder = reponder?.next
        }
        return nil
    }
    
}
