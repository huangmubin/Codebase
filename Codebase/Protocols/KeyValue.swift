//
//  KeyPath.swift
//  TestSwift
//
//  Created by Myron on 2018/5/14.
//  Copyright © 2018年 Myron. All rights reserved.
//

import Foundation

protocol KeyValue {
    func set(key: String, value: Any?)
    func get(key: String) -> Any?
}

class CodeKeys: Codable {
    var name: String = ""
    var i: Int = 0
}


