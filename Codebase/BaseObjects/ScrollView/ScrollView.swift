//
//  ScrollView.swift
//  Days
//
//  Created by Myron on 2018/6/21.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

public class ScrollView: UIScrollView {
    
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
    
    public convenience init(corner: CGFloat) {
        self.init()
        self.layer.cornerRadius = corner
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
    
    
}
