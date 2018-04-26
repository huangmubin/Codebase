//
//  InputTextView.swift
//  My
//
//  Created by Myron on 2018/4/24.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class InputTextView: InputView {

    // MARK: - View Deploy
    
    /** Set the container_size, layouts, add observer */
    override func view_deploy() {
        container_size = CGSize(
            width: bounds.width - 40,
            height: bounds.height / 3
        )
        
        DispatchQueue.main.async {
            self.layout_width.constant = self.container_width()
            self.layout_bottom.constant = self.container_top(bottom: UIScreen.main.bounds.height)
            self.layout_top.constant = self.container_top(bottom: self.layout_bottom.constant)
        }
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboard_observer(_:)),
            name: .UIKeyboardWillChangeFrame,
            object: nil
        )
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
        UIView.animate(withDuration: 0.25, animations: {
            self.layout_bottom.constant = rect.height + 20
            self.layoutIfNeeded()
        }, completion: { _ in
            self.keyboard = rect
        })
    }
    
    /**  */
    func keyboard_down(rect: CGRect) {
        UIView.animate(withDuration: 0.25, animations: {
            self.layout_bottom.constant = 20
            self.layoutIfNeeded()
        }, completion: { [weak self] _ in
            self?.keyboard = nil
            self?.removeFromSuperview()
        })
    }

}
