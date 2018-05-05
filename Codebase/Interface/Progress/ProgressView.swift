//
//  Progress.swift
//  Daily
//
//  Created by Myron on 2018/5/5.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

/**  */
public class ProgressView: UIView {
    
    // MARK: - Init
    
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
}
