//
//  Hint_Progress_List.swift
//  HuaChuang
//
//  Created by Myron on 2018/7/18.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension Hint {
    
    public class ProgressList: Progress {
        
        // MARK: - Objects
        
        let top: Object = {
            let content = Hint.Content_Indicator()
            let obj = Object(id: "ProgressList_Top", content: content)
            return obj
        }()
        
        let info: Object = {
            let content = Hint.Content_Label()
            let obj = Object(id: "ProgressList_Info", content: content)
            content.label.font = UIFont.systemFont(ofSize: UIFont.systemFontSize * 0.8)
            content.color = UIColor.darkGray
            content.label.textColor = content.color
            return obj
        }()
        
        let action: Object = {
            let content = Hint.Content_Button()
            let obj = Object(id: "ProgressList_Button", content: content)
            content.button.setTitle("取消", for: .normal)
            return obj
        }()
        
        // MARK: - Deploy
        
        public override func view_deploy() {
            super.view_deploy()
            progress = 1
            (action.content as! Hint.Content_Button).hint = self
        }
        
        // MARK: - Action
        
        public var cell_defalut_height: CGFloat = 30
        public var cell_defalut_width: CGFloat = UIScreen.main.bounds.width * 0.6
        /** [[Id_String, Left_String, Right_String]] */
        public override func deploy(objs values: Any) {
            objs.forEach({
                $0.content.removeFromSuperview()
                $0.content.stop()
            })
            objs.removeAll()
            objs.append(top)
            if let values = values as? [[String]] {
                for value in values {
                    let content = Hint.Content_Infos()
                    let obj = Object(id: value[0], content: content)
                    content.size = CGSize(
                        width: cell_defalut_width,
                        height: cell_defalut_height
                    )
                    switch value.count {
                    case 0: break
                    case 1:
                        content.left.text = value[0]
                        content.right.text = "0%"
                    case 2:
                        content.left.text = value[0]
                        content.right.text = value[1]
                    case 3:
                        content.left.text = value[1]
                        content.right.text = value[2]
                    case 4:
                        let w = Int(value[3]) ?? Int(cell_defalut_width)
                        content.left.text = value[1]
                        content.right.text = value[2]
                        content.size = CGSize(
                            width: CGFloat(w),
                            height: cell_defalut_height
                        )
                    default:
                        let w = Int(value[3]) ?? Int(cell_defalut_width)
                        let h = Int(value[4]) ?? Int(cell_defalut_height)
                        content.left.text = value[1]
                        content.right.text = value[2]
                        content.size = CGSize(
                            width: CGFloat(w),
                            height: CGFloat(h)
                        )
                    }
                    objs.append(obj)
                }
            }
            objs.append(info)
            objs.append(action)
            
            info.content.size = CGSize(
                width: cell_defalut_width,
                height: cell_defalut_height / 2
            )
            action.content.size = CGSize(
                width: cell_defalut_width,
                height: cell_defalut_height
            )
            reload_objects()
        }
        
        public func update(info value: String?) {
            if let text = value {
                if let content = info.content as? Hint.Content_Label {
                    content.label.text = text
                }
            } else {
                if let index = objs.index(where: { info === $0 }) {
                    objs.remove(at: index)
                    reload_objects()
                }
            }
        }
        
        public func update(action value: String) {
            if let content = action.content as? Hint.Content_Button {
                content.button.setTitle(value, for: .normal)
            }
        }
        
        /** [id_String, right_String] */
        public override func update(_ value: Any) {
            if let values = value as? [String] {
                if values.count == 2 {
                    objs.forEach({
                        if $0.id == values[0] {
                            if let content = $0.content as? Hint.Content_Infos {
                                content.right.text = values[1]
                                return
                            }
                        }
                    })
                }
            }
        }
        
        // MARK: - Action
        
        private var cancel: (() -> Void)?
        public func cancel(_ action: @escaping () -> Void) {
            self.cancel = action
        }
        
        public override func content_action(_ content: Hint.Content, value: Any) {
            self.cancel?()
            self.progress = 0
        }
        
        // MARK: - Close
        
        public override func close() {
            let frame = top.content.frame
            top.content.clear()
            top.content.removeFromSuperview()
            if progress >= 1 {
                top.content = Hint.Content_Success()
            } else {
                top.content = Hint.Content_Error()
            }
            top.content.frame = frame
            addSubview(top.content)
            top.content.run()
            
            DispatchQueue.main.delay(time: top.content.animate_time, execute: {
                if Hint.showing === self {
                    Hint.showing = nil
                }
                self.close_animation()
            })
        }
        
    }
    
}
