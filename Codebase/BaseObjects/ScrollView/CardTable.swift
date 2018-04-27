//
//  CardTable.swift
//  TestSwift
//
//  Created by 黄穆斌 on 2018/4/27.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

/** Card Tablt, use with Card View */ 
public class CardTable: UIScrollView, UIScrollViewDelegate {

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
    public func view_deploy() {
        delegate = self
    }
    
    // MARK: - Cards
    
    /** Cards */
    public var cards: [CardView] = []
    
    // MARK: - Reload
    
    /** 重新加载所有视图 */
    public func reload() {
        for sub in subviews {
            sub.removeFromSuperview()
        }
        for card in cards {
            addSubview(card)
            card.table = self
            card.reload()
        }
    }
    
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
    
    /** Update the cards's edge, can't auto update */
    @IBInspectable var edge: UIEdgeInsets = UIEdgeInsets.zero
    
    /** 大小变化 */
    public func view_bounds() {
        update_content_size()
    }
    
    /** 更新 Container Size */
    public func update_content_size() {
        contentSize.width = bounds.width
        contentSize.height = cards.count(value: {$0.bounds.height}) + (edge.top + edge.bottom) * CGFloat(cards.count)
        var y: CGFloat = 0
        for card in cards {
            card.frame = CGRect(
                x: edge.left, y: y,
                width: bounds.width - edge.left - edge.right,
                height: card.frame.height
            )
            card.update_location()
            y = y + card.frame.height + edge.top + edge.bottom
        }
    }
    
    // MARK: - UIScrollViewDelegate
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let min = scrollView.contentOffset.y
        let max = min + scrollView.bounds.height
        for card in cards {
            switch ((card.frame.minY > max || card.frame.maxY < min),  card.appear) {
            case (true, true):
                card.appear = false
                card.did_disappear()
            case (false, false):
                card.appear = true
                card.did_appear()
            default:break
            }
        }
    }

}
