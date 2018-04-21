//
//  Ex_UISegue.swift
//  My
//
//  Created by Myron on 2018/4/20.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

extension UIStoryboardSegue {
    
    /** Destination controller, if it is navigation then return navigation.viewControllers.first */
    var controller: UIViewController {
        if let navigation = self.destination as? UINavigationController {
            return navigation.viewControllers.first ?? self.destination
        }
        if let tabbar = self.destination as? UITabBarController {
            return tabbar.selectedViewController ?? self.destination
        }
        return self.destination
    }
    
}
