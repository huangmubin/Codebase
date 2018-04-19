//
//  Animation.swift
//  TestSwift
//
//  Created by Myron on 2018/4/18.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

/** 动画工具类 */
public class Animation {
    
    
    
}

// MARK: - Speed

extension Animation {
    
    /**
     Speed 速度工具类
     所有速度函数的 s 参数意思是进度从 0% ~ 100%，反馈出来变化后的进度值。
     */
    public class Speed {
        
        // MARK: 匀速
        
        /** 线性加速 */
        public class func linear(_ s: TimeInterval) -> TimeInterval {
            return s
        }
        
        // MAKR: 先慢后快 加速
        
        /**
         0 = 0.000  1 = 0.001  2 = 0.008  3 = 0.027  4 = 0.064
         5 = 0.125  6 = 0.216  7 = 0.343  8 = 0.512  9 = 0.729
         */
        public class func ease_in(_ s: TimeInterval) -> TimeInterval {
            return pow(s, 3)
        }
        
        /**
         0 = 0.000  1 = 0.010  2 = 0.040  3 = 0.090  4 = 0.160
         5 = 0.250  6 = 0.360  7 = 0.490  8 = 0.640  9 = 0.810
         */
        public class func ease_in_1(_ s: TimeInterval) -> TimeInterval {
            return pow(s, 2)
        }
        
        /**
         0 = 0.000  1 = 0.012  2 = 0.049  3 = 0.109  4 = 0.191
         5 = 0.293  6 = 0.412  7 = 0.546  8 = 0.691  9 = 0.844
         */
        public class func ease_in_2(_ s: TimeInterval) -> TimeInterval {
            return -cos(s * Double.pi / 2) + 1
        }
        
        // MARK: 先快后慢 减速
        
        /**
         0 = 0.000  1 = 0.271  2 = 0.488  3 = 0.657  4 = 0.784
         5 = 0.875  6 = 0.936  7 = 0.973  8 = 0.992  9 = 0.999
         */
        public class func ease_out(_ s: TimeInterval) -> TimeInterval {
            return pow(s, 3) - 3 * pow(s, 2) + 3 * s
        }
        
        /**
         0 = 0.000  1 = 0.190  2 = 0.360  3 = 0.510  4 = 0.640
         5 = 0.750  6 = 0.840  7 = 0.910  8 = 0.960  9 = 0.990
         */
        public class func ease_out_1(_ s: TimeInterval) -> TimeInterval {
            return s * (2 - s)
        }
        
        /**
         0 = 0.000  1 = 0.156  2 = 0.309  3 = 0.454  4 = 0.588
         5 = 0.707  6 = 0.809  7 = 0.891  8 = 0.951  9 = 0.988
         */
        public class func ease_out_2(_ s: TimeInterval) -> TimeInterval {
            return sin(s * Double.pi / 2)
        }
        
        // MARK: - 先慢后快 0.5 先快后慢 先加速再减速
        
        /**
         0 = 0.000  1 = 0.020  2 = 0.080  3 = 0.180  4 = 0.320
         5 = 0.500  6 = 0.680  7 = 0.820  8 = 0.920  9 = 0.980
         */
        public class func ease_in_out(_ s: TimeInterval) -> TimeInterval {
            if s <= 0.5 {
                return pow(s, 2) * 2
            } else {
                return s * 4 - pow(s, 2) * 2 - 1
            }
        }
        
        /**
         0 = 0.000  1 = 0.004  2 = 0.032  3 = 0.108  4 = 0.256
         5 = 0.500  6 = 0.744  7 = 0.892  8 = 0.968  9 = 0.996
         */
        public class func ease_in_out_1(_ s: TimeInterval) -> TimeInterval {
            if s <= 0.5 {
                return pow(s, 3) * 4
            } else {
                return 4 * pow(s, 3) - 12 * pow(s, 2) + 12 * s - 3
            }
        }
        
        /**
         到达后弹簧效果
         */
        public class func bounce(s: TimeInterval) -> TimeInterval {
            if s < 0.3636363636363636 {
                return 7.5625 * s * s
            } else if s < 0.7272727272727273 {
                return 7.5625 * s * s - 8.25 * s + 3
            } else if s < 0.9090909090909091 {
                return 7.5625 * s * s - 12.375 * s + 6
            } else {
                return 7.5625 * s * s - 14.4375 * s + 7.875
            }
        }
        
        /**
         计算弹簧效果值的函数，根据：y = 1-e^{-5x} * cos(30x)
         - parameter s: 当前时间百分比
         - parameter damping: 默认 5, 范围 0 ... 10~， 数值越大则后期弹性效果越不明显。
         - parameter velocity: 默认 30，范围 0 ... 60~，数值越大波动次数越多
         - returns: 百分比
         */
        public class func spring(_ s: TimeInterval, damping: TimeInterval = 5, velocity: TimeInterval = 30) -> TimeInterval {
            return 1 - pow(M_E, -damping * s) * cos(velocity * s)
        }
        
    }
    
}

// MARK: - 动画计算

extension Animation {
    
    class Convert {
        
        /**
         根据输入值跟总长之间的距离，不断递减输出。可用于拖拽不断减少移动距离。
         run: 当前实际数值
         limit: 实际可以达到的比值，0 ~ 100%
         total: 全部总长
         */
        class func slow_down(run: CGFloat, limit: CGFloat, total: CGFloat) -> CGFloat {
            let f: CGFloat = run > 0 ? 1 : -1
            let v: CGFloat = abs(run)
            let s: Double  = Double(v / total)
            return (v - CGFloat(Animation.Speed.ease_in(s)) * (limit * total)) * f
        }
        
    }
    
}
