//
//  Hint_Progress.swift
//  HuaChuang
//
//  Created by Myron on 2018/7/16.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension Hint {
    
    public class Progress: Hint.Hand {
        
        // MARK: - Values
        
        public class Object {
            var content: Hint.Content
            let id: String
            var value: Any?
            var progress: CGFloat = 0
            init(id: String, content: Hint.Content) {
                self.id = id
                self.content = content
            }
        }
        public var objs = [Object]()
        
        // MARK: - Bounds
        
        public override func view_bounds() {
            super.view_bounds()
            var y = edge.top
            for obj in objs {
                obj.content.frame = CGRect(
                    x: (bounds.width - obj.content.size.width) / 2, y: y,
                    width: obj.content.size.width,
                    height: obj.content.size.height
                )
                y = y + obj.content.size.height + space
            }
        }
        
        // MARK: - Deploy
        
        public func reload_objects() {
            for obj in objs {
                addSubview(obj.content)
            }
            var w: CGFloat = 0, h: CGFloat = 0
            objs.forEach({
                w = max(w, $0.content.size.width)
                h = h + $0.content.size.height
            })
            h = h + CGFloat(objs.count - 1) * space + edge.top + edge.bottom
            w = w + edge.left + edge.right
            
            rect_show = CGRect(
                x: (UIScreen.main.bounds.width - w) / 2,
                y: (UIScreen.main.bounds.height - h) / 2,
                width: w, height: h
            )
            rect_hide_default()
            if self.frame.size == rect_show.size {
                self.frame = rect_show
                view_bounds()
            } else {
                self.frame = rect_show
            }
        }
        
        public func deploy(objs: Any) { }
        
        // MARK: - Push
        
        public override func push() {
            super.push()
            for obj in objs {
                obj.content.run()
            }
        }
    }
    
}
