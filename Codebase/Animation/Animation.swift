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
        class func linear(_ s: TimeInterval) -> TimeInterval {
            return s
        }
        
        // MAKR: 先慢后快 加速
        
        /**
         0 = 0.000  1 = 0.001  2 = 0.008  3 = 0.027  4 = 0.064
         5 = 0.125  6 = 0.216  7 = 0.343  8 = 0.512  9 = 0.729
         */
        class func ease_in(_ s: TimeInterval) -> TimeInterval {
            return pow(s, 3)
        }
        
        /**
         0 = 0.000  1 = 0.010  2 = 0.040  3 = 0.090  4 = 0.160
         5 = 0.250  6 = 0.360  7 = 0.490  8 = 0.640  9 = 0.810
         */
        class func ease_in_1(_ s: TimeInterval) -> TimeInterval {
            return pow(s, 2)
        }
        
        /**
         0 = 0.000  1 = 0.012  2 = 0.049  3 = 0.109  4 = 0.191
         5 = 0.293  6 = 0.412  7 = 0.546  8 = 0.691  9 = 0.844
         */
        class func ease_in_2(_ s: TimeInterval) -> TimeInterval {
            return -cos(s * Double.pi / 2) + 1
        }
        
        // MARK: 先快后慢 减速
        
        /**
         0 = 0.000  1 = 0.271  2 = 0.488  3 = 0.657  4 = 0.784
         5 = 0.875  6 = 0.936  7 = 0.973  8 = 0.992  9 = 0.999
         */
        class func ease_out(_ s: TimeInterval) -> TimeInterval {
            return pow(s, 3) - 3 * pow(s, 2) + 3 * s
        }
        
        /**
         0 = 0.000  1 = 0.190  2 = 0.360  3 = 0.510  4 = 0.640
         5 = 0.750  6 = 0.840  7 = 0.910  8 = 0.960  9 = 0.990
         */
        class func ease_out_1(_ s: TimeInterval) -> TimeInterval {
            return s * (2 - s)
        }
        
        /**
         0 = 0.000  1 = 0.156  2 = 0.309  3 = 0.454  4 = 0.588
         5 = 0.707  6 = 0.809  7 = 0.891  8 = 0.951  9 = 0.988
         */
        class func ease_out_2(_ s: TimeInterval) -> TimeInterval {
            return sin(s * Double.pi / 2)
        }
        
        // MARK: - 先慢后快 0.5 先快后慢 先加速再减速
        
        /**
         0 = 0.000  1 = 0.020  2 = 0.080  3 = 0.180  4 = 0.320
         5 = 0.500  6 = 0.680  7 = 0.820  8 = 0.920  9 = 0.980
         */
        class func ease_in_out(_ s: TimeInterval) -> TimeInterval {
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
        class func ease_in_out_1(_ s: TimeInterval) -> TimeInterval {
            if s <= 0.5 {
                return pow(s, 3) * 4
            } else {
                return 4 * pow(s, 3) - 12 * pow(s, 2) + 12 * s - 3
            }
        }
        
    }
    
}
