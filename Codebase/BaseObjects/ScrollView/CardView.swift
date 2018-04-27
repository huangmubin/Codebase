//
//  CardView.swift
//  TestSwift
//
//  Created by 黄穆斌 on 2018/4/27.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

/** Card View, Use in Card Table */
public class CardView: View {

    // MARK: - Table
    
    /** Cart Table */
    public weak var table: CardTable!
    
    // MARK: - Visible
    
    /** is visibility on card table or no */
    public var appear: Bool = false
    
    /** Override: Call when sroll in */
    public func did_appear() {}
    
    /** Override: Call when sroll out */
    public func did_disappear() {}
    
    // MARK: - Reload
    
    /** Override: Reload */
    public func reload() {}

    // MARK: - Resize
    
    /** Override: Call when the table update content size */
    public func update_location() {}
    
    
}
