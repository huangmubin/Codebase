//
//  CardTable.swift
//  TestSwift
//
//  Created by 黄穆斌 on 2018/4/27.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

// MARK: - Card Table DateSource

public protocol CardTableDataSource: class {
    /** 获取数据 */
    func cardTable(dataToCardAt index: Int) -> Any
}

// MARK: - Card Table

/** Card Tablt, use with Card View */ 
public class CardTable: UIScrollView, UIScrollViewDelegate, UIGestureRecognizerDelegate {

    // MARK: - Delegate
    
    /** 数据源 */
    weak var dataSource: CardTableDataSource?
    
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
        tap = UITapGestureRecognizer(target: self, action: #selector(tap_gesture(_:)))
        tap.delegate = self
        addGestureRecognizer(tap)
        keyboard_observer()
    }
    
    // MARK: - Controller
    
    /** Self's Controller */
    public weak var controller: UIViewController?
    
    /** View Controller */
    public var vc: ViewController? {
        return controller as? ViewController
    }
    
    // MARK: - Cards
    
    /** Cards */
    @IBOutlet public var cards: [CardView] = []
    
    /** Find Cards */
    public func card(id: String) -> CardView? {
        return cards.find(condition: { $0.identifier == id })
    }
    
    /** Remove cards */
    @discardableResult
    public func card(remove: String) -> CardView? {
        if let i = cards.index(where: { $0.identifier == remove }) {
            return cards.remove(at: i)
        }
        return nil
    }
    
    // MARK: - Separator
    
    /** Separator: default nil, if no, will add between card */
    @IBOutlet public var separator: CardSeparator? = nil
    
    /**  */
    private var separators: [CardSeparator] = []
    
    // MARK: - Reload
    
    /** 重新加载所有视图 */
    public func reload() {
        for sub in subviews {
            sub.removeFromSuperview()
        }
        
        // Separator
        if let model = separator {
            model.removeFromSuperview()
            let count = cards.count - separators.count - 1
            if count > 0 {
                for _ in 0 ..< count {
                    let line = CardSeparator()
                    separators.append(line)
                }
            } else if count < 0 {
                for _ in 0 ..< -count {
                    if separators.count > 0 {
                        separators.removeFirst()
                    }
                }
            }
            
            for (i, line) in separators.enumerated() {
                line.left = model.left
                line.right = model.right
                line.backgroundColor = model.backgroundColor
                line.frame.origin.x = model.left
                line.frame.size.height = model.frame.height
                line.frame.size.width = bounds.width - model.left - model.right
                line.tag = i
                addSubview(line)
            }
        }
        
        // Card
        for card in cards {
            addSubview(card)
        }
        for (i, card) in cards.enumerated() {
            card.table = self
            card.data = dataSource?.cardTable(dataToCardAt: i)
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
    
    /** Update the cards's edge, can't auto update
     x: top
     y: down
     w: left
     h: right
     */
    @IBInspectable var ib_edge: CGRect = CGRect.zero {
        didSet {
            edge = UIEdgeInsets(
                top: ib_edge.origin.x,
                left: ib_edge.width,
                bottom: ib_edge.origin.y,
                right: ib_edge.height
            )
        }
    }
    /** Update the cards's edge, can't auto update */
    public var edge: UIEdgeInsets = UIEdgeInsets.zero
    
    /** 大小变化 */
    public func view_bounds() {
        update_content_size()
    }
    
    /** 更新 Container Size */
    public func update_content_size() {
        let separator_height = (separator == nil ? 0 : (CGFloat(cards.count) * separator!.frame.height))
        contentSize.width = bounds.width
        contentSize.height = cards.count(value: { $0.bounds.height + $0.space_edge.top + $0.space_edge.bottom }) + (edge.top + edge.bottom) * CGFloat(cards.count) + separator_height
        var y: CGFloat = edge.top
        for (i, card) in cards.enumerated() {
            y += card.space_edge.top
            card.frame = CGRect(
                x: edge.left + card.space_edge.left, y: y,
                width: bounds.width - edge.left - edge.right - card.space_edge.left - card.space_edge.right,
                height: card.frame.height
            )
            card.update_location()
            y += card.space_edge.bottom
            y = y + card.frame.height + edge.top + edge.bottom
            if let line = separators.find(condition: { $0.tag == i }) {
                line.frame.origin.y = y
                line.frame.size.width = bounds.width - line.left - line.right
                y = y + line.frame.height
            }
        }
    }
    
    // MARK: - UIScrollViewDelegate
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        for card in cards {
            card.scroll_begin_dragging_action()
        }
    }
    
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
            //
            if card.appear {
                card.scroll_action()
            }
        }
    }

    // MARK: - Touch
    
    /**  */
    public var tap: UITapGestureRecognizer!
    
    /**  */
    @objc public func tap_gesture(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: self)
        for card in cards {
            if card.appear && card.frame.minY < point.y && card.frame.maxY > point.y {
                card.tap_gesture(sender)
            }
        }
    }
    
    // MARK: - UIGestureRecognizerDelegate
    
    /** Check is Touch Cell or not */
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if gestureRecognizer === tap {
            var view = touch.view
            while view != nil {
                switch view {
                case is UICollectionViewCell, is UITableViewCell:
                    return false
                default:
                    view = view?.superview
                }
            }
        }
        return true
    }
    
    // MARK: - Keyboard
    
    /** Is it listion the keyboard changed. */
    @IBInspectable public var keyboard: Bool = true {
        didSet {
            keyboard_observer()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public func keyboard_observer() {
        if keyboard {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(keyboard_will_change_frame(_:)),
                name: .UIKeyboardWillChangeFrame,
                object: nil
            )
        } else {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    
    @objc func keyboard_will_change_frame(_ notification: Notification) {
        if let info = notification.userInfo {
            if let rect = info[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                self.keyboard_will_change_frame(keyboard: rect.cgRectValue)
            }
        }
    }
    
    /** keyboard will change to the new rect, default change the contentoffset */
    public func keyboard_will_change_frame(keyboard rect: CGRect) {
        if rect.minY < UIScreen.main.bounds.height {
            UIView.animate(withDuration: 0.25, animations: {
                self.contentInset.bottom = rect.height
            })
        } else {
            UIView.animate(withDuration: 0.25, animations: {
                self.contentInset.bottom = 0
            })
        }
    }
    
}
