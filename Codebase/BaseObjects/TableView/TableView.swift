//
//  TableView.swift
//  My
//
//  Created by Myron on 2018/4/20.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

/** Table View 特殊方法 */
public class TableView: UITableView {
    
    // MARK: - Init
    
    public init() {
        super.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        view_deploy()
    }
    
    public override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        view_deploy()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view_deploy()
    }
    
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
