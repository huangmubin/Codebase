//
//  InputTextView.swift
//  My
//
//  Created by Myron on 2018/4/24.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class InputTextView: InputView {

    // MARK: - Text View
    
    @IBOutlet weak var text: UITextView!
    
    // MARK: - View Deploy
    
    /** Set the container_size, layouts, add observer */
    override func view_deploy() {
        container_size = CGSize(
            width: bounds.width - 40,
            height: bounds.height / 3
        )
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboard_observer(_:)),
            name: .UIKeyboardWillChangeFrame,
            object: nil
        )
    }
    
    /** */
    override public func deploy_layout() {
        self.layout_width.constant = self.container_width()
        self.layout_top.constant = self.container_top(maxY: self.bounds.height)
        self.layout_bottom.constant = self.container_down(minY: self.layout_top.constant)
    }
    
    // MARK: - Action
    
    override func delegate_action() {
        delegate?.inputView(self, save_action: text.text)
    }
    
    // MARK: - Animate
    
    /** Override open animate completed */
    override func animate_did_open() {
        text.becomeFirstResponder()
    }
    
    // MARK: - Key board Observer
    
    /** Keyboard observer */
    @objc func keyboard_observer(_ sender: NSNotification) {
        if let info = sender.userInfo {
            if let rect_value = info[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                let rect = rect_value.cgRectValue
                if rect.minY >= UIScreen.main.bounds.height - 20 {
                    self.keyboard_down(rect: rect)
                } else {
                    self.keyboard_show(rect: rect)
                }
            }
        }
    }
    
    // MARK: - Animate
    
    /** The keyboard rect, is nill then is close. */
    var keyboard: CGRect? = nil
    
    /**  */
    func keyboard_show(rect: CGRect) {
        let top = self.container_top(maxY: rect.minY - 20)
        let down = self.container_down(minY: top)
        UIView.animate(withDuration: 0.25, animations: {
            self.layout_top.constant = top
            self.layout_bottom.constant = down
            self.layoutIfNeeded()
        }, completion: { _ in
            self.keyboard = rect
        })
    }
    
    /**  */
    func keyboard_down(rect: CGRect) {
        let top = self.container_top(maxY: rect.minY - 20)
        let down = self.container_down(minY: top)
        UIView.animate(withDuration: 0.25, animations: {
            self.layout_top.constant = top
            self.layout_bottom.constant = down
            self.layoutIfNeeded()
        }, completion: { [weak self] _ in
            self?.keyboard = nil
            self?.removeFromSuperview()
        })
    }

}
