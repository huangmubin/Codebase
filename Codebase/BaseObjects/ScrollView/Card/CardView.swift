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

    // MARK: - Init
    
    /** default init */
    convenience init(height: CGFloat?) {
        self.init(frame: CGRect(x: 0, y: 0, width: 300, height: height ?? 80))
        if height != nil {
            if height! != 80 {            
                self.default_height = height!
                self.frame.size.height = default_height
            }
        }
        self.clipsToBounds = true
    }
    
    /** default init */
    convenience init(id: String, height: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: 300, height: height))
        self.identifier = id
        self.default_height = height
        self.clipsToBounds = true
    }
    
    // MARK: - Table
    
    /** Cart Table */
    public weak var table: CardTable!
    
    // MARK: - Data
    
    /** Data */
    public var data: Any? = nil
    
    /** default height */
    public var default_height: CGFloat = 80
    
    /** default space, the card and the scroll view space */
    public var space_edge: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
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
    
    /** Override: Scroll Action, Call when appear and scroll. */
    public func scroll_begin_dragging_action() {}
    
    // MARK: - Gesture
    
    /** Override: Tap Select */
    public func tap_gesture(_ sender: UITapGestureRecognizer) {}
    
}
