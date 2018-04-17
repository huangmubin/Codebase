//
//  Ex_UIScreen.swift
//  TestSwift
//
//  Created by Myron on 2018/4/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

// MARK: - Size

extension UIScreen {
    
    /**  */
    var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    /**  */
    var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    /**  */
    var bounds: CGRect {
        return UIScreen.main.bounds
    }
    
}
