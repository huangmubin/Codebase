//
//  Button.swift
//  TestSwift
//
//  Created by Myron on 2018/4/18.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

/**
 使用该对象后，不可使用原生 UIButton 的状态变化方法。
 */
public class Button: UIButton {
    
    // MARK: - Note
    
    /** note value */
    @IBInspectable var note: String = ""
    
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
    
    // MARK: - Status
    
    /** 按钮状态枚举 */
    public enum ButtonStatus: Int {
        case normal = 0
        case selected
        case invalid
    }
    
    /** 按钮状态 */
    public var status: ButtonStatus = .normal {
        didSet { status_update() }
    }
    
    /** 按钮状态 */
    private func status_update() {
        switch status {
        case .normal:
            self.backgroundColor = normal_color
            self.setTitleColor(self.titleColor(for: .normal), for: .normal)
        case .selected:
            self.backgroundColor = selected_color
            self.setTitleColor(self.titleColor(for: .selected), for: .normal)
        case .invalid:
            self.backgroundColor = invalid_color
            self.setTitleColor(self.titleColor(for: .disabled), for: .normal)
        }
    }
    
    // MARK: Status Value
    
    /**  */
    public var is_normal: Bool {
        return status == .normal
    }
    
    /**  */
    public var is_selected: Bool {
        return status == .selected
    }
    
    /**  */
    public var is_invalid: Bool {
        return status == .invalid
    }
    
    // MARK: - Color Value
    
    /**  */
    @IBInspectable public var normal_color: UIColor = UIColor.white {
        didSet {
            if is_normal {
                self.backgroundColor = normal_color
            }
        }
    }
    
    /**  */
    @IBInspectable public var selected_color: UIColor = UIColor.clear {
        didSet {
            if is_selected {
                self.backgroundColor = selected_color
            }
        }
    }
    
    /**  */
    @IBInspectable public var invalid_color: UIColor = UIColor.clear {
        didSet {
            if is_invalid {
                self.backgroundColor = invalid_color
            }
        }
    }
}

