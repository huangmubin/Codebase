//
//  VarlenaInput.swift
//  TestSwift
//
//  Created by Myron on 2018/5/4.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit


/** 变长的输入框 */
public class VarlenaInput: View {
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Value
    
    /**  */
    @IBInspectable var space: CGFloat = 8
    
    /**  */
    @IBInspectable var auto: Bool = true
    
    // MARK: - Input
    
    /**  */
    @IBOutlet weak var input: UITextField! {
        didSet {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(textFieldDidChange(_:)),
                name: .UITextFieldTextDidChange,
                object: input
            )
        }
    }
    
    // MARK: - Prefix Suffix
    
    /**  */
    @IBOutlet weak var prefix: UILabel!
    /**  */
    @IBOutlet weak var suffix: UILabel!
    
    // MAKR: - Layout
    
    /**  */
    @IBOutlet weak var layout: NSLayoutConstraint!
    
    /**  */
    @objc func textFieldDidChange(_ notify: Notification) {
        if auto {        
            let w = input.sizeThatFits(CGSize(width: 0, height: 0)).width + space
            if w != layout.constant {
                UIView.animate(withDuration: 0.25, animations: {
                    self.layout.constant = w
                    self.layoutIfNeeded()
                })
            }
        }
    }
    
}
