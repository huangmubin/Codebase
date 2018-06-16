//
//  Ex_String.swift
//  My
//
//  Created by Myron on 2018/4/20.
//  Copyright © 2018年 myron. All rights reserved.
//

import Foundation

// MARK: - 正则表达式

extension String {
    
    /**
     caseInsensitive 不区分字母大小写
     allowCommentsAndWhitespace 忽略正则表达式中的空格和#号之后的字符
     ignoreMetacharacters 将正则表达式整体作为字符串处理
     dotMatchesLineSeparators 允许.匹配任何字符，包括换行
     anchorsMatchLines 允许^和$符号匹配行的开头和结尾
     useUnixLineSeparators 设置\n为唯一的行分隔符，否则所有的都有效。
     useUnicodeWordBoundaries 使用Unicode TR#29标准作为词的边界，否则所有传统正则表达式的词边界都有效
     */
    func regular(pattern: String, options: NSRegularExpression.Options, range: NSRange) -> [NSTextCheckingResult] {
        if let obj = try? NSRegularExpression(
            pattern: pattern,
            options: options
            ) {
            return obj.matches(in: self, options: [], range: range)
        } else {
            return []
        }
    }
    
    func regular_strings(pattern: String, options: NSRegularExpression.Options? = nil, range: NSRange? = nil) -> [String] {
        let text_range = regular(
            pattern: pattern,
            options: options ?? [],
            range: range ?? NSRange(location: 0, length: self.utf16.count)
        )
        let text = self as NSString
        return text_range.map({ text.substring(with: $0.range) })
    }
    
    func regular_match(pattern: String, options: NSRegularExpression.Options? = nil, range: NSRange? = nil) -> Bool {
        if let obj = try? NSRegularExpression(
            pattern: pattern,
            options: options ?? []
            ) {
            return obj.numberOfMatches(
                in: self,
                options: [],
                range: range ?? NSRange(location: 0, length: self.utf16.count)
            ) > 0
        } else {
            return false
        }
    }
    
}
