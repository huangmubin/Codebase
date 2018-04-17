//
//  NibLoable.swift
//  TestSwift
//
//  Created by Myron on 2018/4/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

/** 为 View 提供可以直接从 xib 文件中加载的便捷方法 */
public protocol NibLoable { }

// MARK: - View

extension NibLoable where Self: UIView {
    
    /** 从 xib 里加载 View */
    public static func load(nib: String? = nil) -> Self? {
        return Bundle.main.loadNibNamed(nib ?? "\(self)", owner: nil, options: nil)?.first as? Self
    }
    
}
extension UIView: NibLoable { }

// MARK: - ViewController

extension NibLoable where Self: UIViewController {
    
    /** 从 xib 里加载 ViewController */
    public static func load(nib: String? = nil) -> Self? {
        return UIViewController(nibName: nib, bundle: .main) as? Self
    }
    
}
extension UIViewController: NibLoable { }


