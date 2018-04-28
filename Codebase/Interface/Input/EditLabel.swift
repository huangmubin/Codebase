//
//  EditLabel.swift
//  My
//
//  Created by Myron on 2018/4/28.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

class EditLabel: UIView {

    /** 文本 */
    var text: String {
        return "\(prefix?.text ?? "")\(field?.text ?? "")\(suffix?.text ?? "")"
    }
    
    
    // MARK: - Deinit
    
    deinit { NotificationCenter.default.removeObserver(self) }
    
    // MARK: - Labels
    
    /**  */
    @IBOutlet weak var prefix: UILabel!
    /**  */
    @IBOutlet weak var suffix: UILabel!
    
    // MARK: - Field
    
    /**  */
    @IBOutlet weak var layout: NSLayoutConstraint!
    /**  */
    @IBOutlet weak var field: UITextField! {
        didSet {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(textFieldDidChange(_:)),
                name: .UITextFieldTextDidChange,
                object: field
            )
        }
    }
    
    /**  */
    @IBInspectable var space: CGFloat = 8
    
    /**  */
    @objc func textFieldDidChange(_ notify: Notification) {
        UIView.animate(withDuration: 0.25, animations: {
            self.layout?.constant = self.field.sizeThatFits(self.field.bounds.size).width + self.space
            self.layoutIfNeeded()
        })
    }

}
