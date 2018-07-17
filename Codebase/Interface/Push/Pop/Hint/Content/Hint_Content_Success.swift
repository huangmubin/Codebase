//
//  Hint_Content_Success.swift
//  HuaChuang
//
//  Created by Myron on 2018/7/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension Hint {
    
    public class Content_Success: Hint.Content {
        
        public override func view_deploy() {
            super.view_deploy()
            layer.addSublayer(shape)
            shape.strokeEnd = 0
            shape.lineWidth = 3
            shape.lineCap = kCALineCapRound
            shape.lineJoin = kCALineJoinRound
            shape.strokeColor = color.cgColor
            shape.fillColor = UIColor.clear.cgColor
        }
        
        public override func view_bounds() {
            super.view_bounds()
            //shape.frame = bounds
            let path = UIBezierPath()
            path.move(
                to: CGPoint(x: bounds.width * 0, y: bounds.height * 0.55)
            )
            path.addLine(
                to: CGPoint(x: bounds.width * 0.4, y: bounds.height * 0.85)
            )
            path.addLine(
                to: CGPoint(x: bounds.width * 0.9, y: bounds.height * 0.3)
            )
            path.lineCapStyle = CGLineCap.round
            path.lineJoinStyle = CGLineJoin.round
            shape.path = path.cgPath
        }
        
        // MARK: - Layer
        
        public let shape = CAShapeLayer()
        
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
                self.shape.add(end, forKey: "strokeEnd")
            })
            
            DispatchQueue.main.delay(time: 0.5, execute: {
                let start = CABasicAnimation(keyPath: "strokeStart")
                start.fromValue = 0
                start.toValue = 0.1
                start.isRemovedOnCompletion = false
                start.fillMode = kCAFillModeForwards
                start.duration = 0.5
                start.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
                self.shape.add(start, forKey: "strokeStart")
            })
        }
        
        /*
         let animte = CASpringAnimation(keyPath: "strokeEnd")
         animte.toValue = 1
         animte.mass = 5 // mass模拟的是质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大 默认值：1 ；
         animte.stiffness = 100 // stiffness刚度系数(劲度系数/弹性系数)，刚度系数越大，形变产生的力就越大，运动越快。默认值： 100 ；
         animte.damping = 10 // damping阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快。默认值：10；
         animte.initialVelocity = 100 // initialVelocity初始速率，动画视图的初始速度大小。默认值：0 ；
         animte.duration = animte.settlingDuration // settlingDuration估算时间 返回弹簧动画到停止时的估算时间，根据当前的动画参数估算；
         animte.isRemovedOnCompletion = false // removedOnCompletion 默认为YES 。当设置为YES时，动画结束后，移除layer层的；当设置为NO时，保持动画结束时layer的状态；
         animte.fillMode = kCAFillModeForwards
         /*
         fillMode属性的设置：
         
         kCAFillModeRemoved  这个是默认值，也就是说当动画开始前和动画结束后，
         动画对layer都没有影响，动画结束后，layer会恢复到之前的状态
         
         kCAFillModeForwards 当动画结束后，layer会一直保持着动画最后的状态
         
         kCAFillModeBackwards  在动画开始前，只需要将动画加入了一个layer，
         layer便立即进入动画的初始状态并等待动画开始。
         
         kCAFillModeBoth 这个其实就是上面两个的合成.动画加入后开始之前，
         layer便处于动画初始状态，动画结束后layer保持动画最后的状态
         */
         shape.add(animte, forKey: "etrokeEnd")
         */
        
    }
    
}
