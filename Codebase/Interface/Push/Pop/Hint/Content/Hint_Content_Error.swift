//
//  Hint_Content_Error.swift
//  HuaChuang
//
//  Created by Myron on 2018/7/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension Hint {
    
    public class Content_Error: Hint.Content {
        
        public override func view_deploy() {
            super.view_deploy()
            for shape in [shape1, shape2] {
                layer.addSublayer(shape)
                shape.strokeEnd = 0
                shape.lineWidth = 3
                shape.lineCap = kCALineCapRound
                shape.lineJoin = kCALineJoinRound
                shape.strokeColor = color.cgColor
                shape.fillColor = UIColor.clear.cgColor
            }
        }
        
        public override func view_bounds() {
            super.view_bounds()
            shape1_bounds()
            shape2_bounds()
        }
        
        private func shape1_bounds() {
            let path = UIBezierPath()
            path.move(
                to: CGPoint(x: bounds.width * 0, y: bounds.height * 0.1)
            )
            path.addLine(
                to: CGPoint(x: bounds.width * 0.1, y: bounds.height * 0.1)
            )
            path.addLine(
                to: CGPoint(x: bounds.width * 0.9, y: bounds.height * 0.9)
            )
            shape1.path = path.cgPath
        }
        private func shape2_bounds() {
            let path = UIBezierPath()
            path.move(
                to: CGPoint(x: bounds.width * 1.0, y: bounds.height * 0.1)
            )
            path.addLine(
                to: CGPoint(x: bounds.width * 0.9, y: bounds.height * 0.1)
            )
            path.addLine(
                to: CGPoint(x: bounds.width * 0.1, y: bounds.height * 0.9)
            )
            shape2.path = path.cgPath
        }
        
        // MARK: - Layer
        
        public let shape1 = CAShapeLayer()
        public let shape2 = CAShapeLayer()
        
        public var color: UIColor = UIColor.black
        
        // MARK: - Run
        
        public override func run() {
            DispatchQueue.main.delay(time: 0.2, execute: {
                let end = CABasicAnimation(keyPath: "strokeEnd")
                end.fromValue = 0
                end.toValue = 1
                end.isRemovedOnCompletion = false
                end.fillMode = kCAFillModeForwards
                end.duration = 0.5
                end.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
                self.shape1.add(end, forKey: "strokeEnd")
                self.shape2.add(end, forKey: "strokeEnd")
            })

            DispatchQueue.main.delay(time: 0.5, execute: {
                let start = CABasicAnimation(keyPath: "strokeStart")
                start.fromValue = 0
                start.toValue = 0.088
                start.isRemovedOnCompletion = false
                start.fillMode = kCAFillModeForwards
                start.duration = 0.5
                start.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
                self.shape1.add(start, forKey: "strokeStart")
                self.shape2.add(start, forKey: "strokeStart")
            })
        }
        
    }
    
}
