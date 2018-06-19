//
//  Ex_DispathQueue.swift
//  Days
//
//  Created by Myron on 2018/6/19.
//  Copyright © 2018年 Myron. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    /** Delay and running */
    func delay(time: TimeInterval, execute: @escaping () -> Void) {
        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: time)
            self.async(execute: execute)
        }
    }
    
}
