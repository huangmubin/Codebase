//
//  InputView.swift
//  My
//
//  Created by Myron on 2018/4/24.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

/** Input View Delegate */
public protocol InputViewDelegate: class {
    /** Cell when input view's save action */
    func inputView(_ view: InputView, save_action value: Any)
}

/** Input View */
public class InputView: UIView {

    // MARK: - Init
    
    /**  */
    public override init(frame: CGRect) {
        super.init(frame: frame)
        view_deploy()
    }
    
    /**  */
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view_deploy()
    }
    
    /**  */
    convenience public init(delegate: InputViewDelegate) {
        self.init(frame: UIScreen.main.bounds)
        self.delegate = delegate
    }
    
    /** deinit Remove observer */
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Super View
    
    public override func didMoveToSuperview() {
        self.animate_open()
    }
    
    // MARK: - Deploy
    
    /** Call when init */
    public func view_deploy() { }
    
    // MARK: - Delegate
    
    /** Delegate */
    @IBOutlet weak var i_delegate: NSObject? = nil {
        didSet {
            if let i = i_delegate as? InputViewDelegate {
                self.delegate = i
            }
        }
    }
    
    /** InputViewDelegate */
    public weak var delegate: InputViewDelegate?
    
    /** Override: Delegate Action */
    public func delegate_action() { }
    
    // MARK: - Size
    
    /** Frame */
    override public var frame: CGRect {
        didSet{
            if frame.size != oldValue.size {
                view_bounds()
            }
        }
    }
    /** Bounds */
    override public var bounds: CGRect {
        didSet {
            if bounds.size != oldValue.size {
                view_bounds()
            }
        }
    }
    /** 大小变化 */
    public func view_bounds() {
        effect.frame = bounds
    }
    
    // MARK: - Effect
    
    /** UIVisualEffectView */
    @IBOutlet weak var effect: UIVisualEffectView!
    
    // MARK: - Animate
    
    /** Open Animate */
    private func animate_open() {
        self.alpha = 0
        self.animate_will_open()
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1
        }, completion: { _ in
            self.animate_did_open()
        })
    }
    
    /** Override open animate completed */
    public func animate_will_open() { }
    /** Override open animate completed */
    public func animate_did_open() { }
    
    /** Open Animate */
    private func animate_close(is_save: Bool) {
        animate_will_close()
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0
        }, completion: { [weak self] _ in
            self?.animate_did_close()
            if is_save { self?.delegate_action() }
            self?.removeFromSuperview()
        })
    }
    
    /** Override close animate completed */
    public func animate_will_close() { }
    /** Override close animate completed */
    public func animate_did_close() { }
    
    // MARK: - SubView
    
    /** Back ground View */
    @IBOutlet weak var back_view: View!
    
    /** Title Label */
    @IBOutlet weak var title: UILabel!
    
    /** Cancel Button */
    @IBOutlet weak var cancel: UIButton!
    
    /** Cancel Action */
    @IBAction func cancel_action(_ sender: UIButton) {
        animate_close(is_save: false)
    }
    
    /** Save Button */
    @IBOutlet weak var save: UIButton!
    
    /** Save Action */
    @IBAction func save_action(_ sender: UIButton) {
        animate_close(is_save: true)
    }
    
    // MARK: - Container
    
    /** Container View */
    @IBOutlet weak var container: UIView!
    
    /** Container Size */
    public var container_size: CGSize = CGSize()
    
    /**  */
    public func container_width() -> CGFloat {
        return container_size.width - bounds.width
    }
    
    /** bottom is the maxY */
    public func container_top(maxY: CGFloat) -> CGFloat {
        let minY = (bounds.height - container_size.height) / 2
        if minY + container_size.height > maxY {
            return max(maxY - container_size.height, 20)
        } else {
            return minY
        }
    }
    
    /**  */
    public func container_down(minY: CGFloat) -> CGFloat {
        return bounds.height - minY - container_size.height
    }
    
    // MARK: - Layout
    
    /**  */
    @IBOutlet weak var layout_top: NSLayoutConstraint!
    /**  */
    @IBOutlet weak var layout_bottom: NSLayoutConstraint!
    /**  */
    @IBOutlet weak var layout_center: NSLayoutConstraint!
    /**  */
    @IBOutlet weak var layout_width: NSLayoutConstraint!
    
    
    
    
    
}
