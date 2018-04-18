//
//  ImageView.swift
//  TestSwift
//
//  Created by Myron on 2018/4/18.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

/**
 
 */
public class ImageView: UIImageView {
    
    // MARK: - Storyboard
    
    // MARK: 圆角控制
    
    /**  */
    @IBInspectable public var corner: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = corner
            self.mask?.layer.cornerRadius = corner
        }
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
    
    // MARK: - Init
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        view_deploy_private()
        view_deploy()
    }
    override public init(image: UIImage?) {
        super.init(image: image)
        view_deploy_private()
        view_deploy()
    }
    override public init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        view_deploy_private()
        view_deploy()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view_deploy_private()
        view_deploy()
    }
    
    /** 初始化 */
    private func view_deploy_private() {
        mask = UIView()
        mask?.frame = bounds
        mask?.backgroundColor = UIColor.black
    }
    
    /** 初始化 */
    public func view_deploy() { }
    
    // MARK: - Size
    
    override public var frame: CGRect {
        didSet{
            if frame.size != oldValue.size {
                mask?.frame = bounds
                view_bounds()
            }
        }
    }
    override public var bounds: CGRect {
        didSet {
            if bounds.size != oldValue.size {
                mask?.frame = bounds
                view_bounds()
            }
        }
    }
    
    /** 大小变化 */
    public func view_bounds() { }
    
}
