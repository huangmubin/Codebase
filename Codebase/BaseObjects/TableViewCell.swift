//
//  TableViewCell.swift
//  TestSwift
//
//  Created by Myron on 2018/4/18.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

/**
 
 */
public class TableViewCell: UITableViewCell {
    
    // MARK: - Init
    
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    
    // MARK: - Loads
    
    /** is loaded */
    private var is_loaded = false
    /** */
    public func view_load() { }
    /** */
    public func view_reload() { }
    
}

// MARK: - Extension View Controller

extension UIViewController {
    
    /** Override in UIViewController to receive TableViewCell's massage */
    public func tableView(cell: TableViewCell, user action: String, value: Any? = nil) { }
    
}
