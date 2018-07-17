//
//  XML.swift
//  HuaChuang
//
//  Created by Myron on 2018/7/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import Foundation

class XML: NSObject, XMLParserDelegate {
    
    class Object {
        var name: String = ""
        var value: String = ""
        var attributes: [String: String] = [:]
        var subs: [Object] = []
    }
    
    let parser: XMLParser
    var queue: [Object] = []
    var object: Object?
    
    init(data: Data) {
        parser = XMLParser(data: data)
        super.init()
        parser.delegate = self
        parser.parse()
    }
    
    func parserDidStartDocument(_ parser: XMLParser) {
        //print("parserDidStartDocument")
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        //print("didStartElement: element name = \(elementName); url = \(String(describing: namespaceURI)); qName = \(String(describing: qName)); attributes = \(attributeDict);")
        let obj = Object()
        obj.name = elementName
        obj.attributes = attributeDict
        
        object = queue.last
        queue.append(obj)
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        //print("foundCharacters: \(string)")
        if !is_end {
            queue.last?.value = string
        } else {
            is_end = false
        }
    }
    
    private var is_end: Bool = false
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //print("didEndElement: element name = \(elementName); url = \(String(describing: namespaceURI)); qName = \(String(describing: qName))")
        is_end = true
        let obj = queue.removeLast()
        if object === obj {
            if queue.count > 0 {
                object = queue.last
                object?.subs.append(obj)
            } else {
                // 文档结束
            }
        } else {
            object?.subs.append(obj)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        //print("parserDidEndDocument")
    }
    
}
