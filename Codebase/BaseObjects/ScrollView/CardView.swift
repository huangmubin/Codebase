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
    
    // MARK: - Data
    
    /** Data */
    public var data: Any? = nil
    
    // MARK: - identifier
    
    /** identifier */
    @IBInspectable var identifier: String = ""
    
    /** Index */
    @IBInspectable var index: Int = 0
    
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
    
    // MARK: - Scroll
    
    /** Override: Scroll Action, Call when appear and scroll. */
    public func scroll_action() {}
    
    // MARK: - Gesture
    
    /** Override: Tap Select */
    public func tap_gesture(_ sender: UITapGestureRecognizer) {}
    
    
}
