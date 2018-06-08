//
//  CollectionViewCell.swift
//  Days
//
//  Created by Myron on 2018/5/24.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

public class CollectionViewCell: UICollectionViewCell {
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        view_deploy()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view_deploy()
    }
    
    /** View Deploy */
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
    
    // MARK: - Massage
    
    /** Cell Index Path */
    public var index: IndexPath!
    
    // MARK: Controller
    
    /** Cell's tableview's controller */
    public weak var controller: ViewController?
    
    /** Cell Update */
    public func view_update(index: IndexPath, controller: ViewController?) {
        self.index = index
        self.controller = controller
        if !is_loaded {
            view_load()
            is_loaded = true
        }
        view_reload()
    }
    
    // MARK: View
    
    /** Cell's tableview's view */
    public weak var view: UIView?
    
    /** Cell Update */
    public func view_update(index: IndexPath, view: UIView?) {
        self.index = index
        self.view = view
        if !is_loaded {
            view_load()
            is_loaded = true
        }
        view_reload()
    }
    
    // MARK: - Loads
    
    /** is loaded */
    private var is_loaded = false
    /** */
    public func view_load() { }
    /** */
    public func view_reload() { }
    
}
