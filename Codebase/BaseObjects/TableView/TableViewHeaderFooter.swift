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
