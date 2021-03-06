//
//  TableViewHeaderFooter.swift
//  Days
//
//  Created by Myron on 2018/5/19.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

public class TableViewHeaderFooter: UITableViewHeaderFooterView {

    // MARK: - Init
    
    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        view_deploy()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view_deploy()
    }
    
    /** View Deploy */
    public func view_deploy() { }
    
    // MARK: - Massage
    
    /** Cell Index Path */
    public var section: Int = 0
    
    // MARK: Controller
    
    /** Cell's tableview's controller */
    public weak var controller: ViewController?
    
    /** Cell Update */
    public func view_update(section: Int, controller: ViewController?) {
        self.section = section
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
    public func view_update(section: Int, view: UIView?) {
        self.section = section
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
    public func view_load() {
        back_view.backgroundColor = UIColor.white
        addSubview(back_view)
        addSubview(title_label)
    }
    /** */
    public func view_reload() { }
    
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
    public func view_bounds() {
        back_view.frame = bounds
        title_label.frame = CGRect(
            x: 20, y: 0,
            width: bounds.width - 40,
            height: bounds.height
        )
    }

    // MARK: - Subviews
    
    /**  */
    public let back_view: UIView = UIView()
    /**  */
    public let title_label: UILabel = UILabel()
    
}
