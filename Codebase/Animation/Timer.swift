//
//  Timer.swift
//  Days
//
//  Created by Myron on 2018/6/10.
//  Copyright © 2018年 Myron. All rights reserved.
//

import Foundation

protocol TimerDelegate: class {
    func timer_update(total: Int, time: Int, interval: DispatchTimeInterval)
    func timer_finish(total: Int, time: Int, interval: DispatchTimeInterval)
}

class Timer {
    
    // MARK: - Init
    
    convenience init(delegate: TimerDelegate) {
        self.init()
        self.delegate = delegate
    }
    
    // MARK: - Value
    
    /** Timer Object */
    fileprivate var timer: DispatchSourceTimer? = nil
    
    /***/
    weak var delegate: TimerDelegate?
    /** Total */
    var total: Int = 0
    /** Call back time */
    var time: Int = 0
    
    // MARK: - Action
    
    /** 每秒回调一次 */
    func run(second value: Int) {
        run(time: value, interval: DispatchTimeInterval.seconds(1))
    }
    
    /** 自定义毫秒回调一次 */
    func run(millisecond value: Int, space: Int) {
        run(time: value, interval: DispatchTimeInterval.milliseconds(space))
    }
    
    /** Call */
    private func run(time value: Int, interval: DispatchTimeInterval) {
        total += value
        time += value
        guard time > 0 && timer == nil else { return }
        timer = DispatchSource.makeTimerSource(
            flags: DispatchSource.TimerFlags(rawValue: 1),
            queue: DispatchQueue.main
        )
        timer?.schedule(
            wallDeadline: DispatchWallTime.now(),
            repeating: interval
        )
        timer?.setEventHandler(handler: { [weak self] in
            if let w_self = self {
                if w_self.time < 0 {
                    self?.delegate?.timer_finish(
                        total: w_self.total,
                        time: 0,
                        interval: interval
                    )
                    self?.timer?.cancel()
                    self?.timer = nil
                } else {
                    w_self.time -= 1
                    self?.delegate?.timer_update(
                        total: w_self.total,
                        time: w_self.time,
                        interval: interval
                    )
                }
            }
        })
        timer?.resume()
    }
    
}
