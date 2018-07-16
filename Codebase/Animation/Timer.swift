//
//  Timer.swift
//  Days
//
//  Created by Myron on 2018/6/10.
//  Copyright © 2018年 Myron. All rights reserved.
//

import Foundation

public protocol TimerDelegate: class {
    func timer_update(total: Int, time: Int, interval: DispatchTimeInterval)
    func timer_finish(total: Int, time: Int, interval: DispatchTimeInterval)
}

public class Timer {
    
    public func clear() {
        timer?.cancel()
        timer = nil
        delegate = nil
    }
    
    // MARK: - Init
    
    public convenience init(delegate: TimerDelegate) {
        self.init()
        self.delegate = delegate
    }
    
    // MARK: - Value
    
    /** Timer Object */
    fileprivate var timer: DispatchSourceTimer? = nil
    
    /***/
    public weak var delegate: TimerDelegate?
    /** Total */
    public var total: Int = 0
    /** Call back time */
    public var time: Int = 0
    
    // MARK: - Action
    
    /** 每秒回调一次 */
    public func run(second value: Int) {
        run(time: value, interval: DispatchTimeInterval.seconds(1))
    }
    
    /** 自定义毫秒回调一次 */
    public func run(millisecond value: Int, space: Int) {
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
