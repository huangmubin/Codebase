//
//  iSelectorCombine.swift
//  Days
//
//  Created by Myron on 2018/7/13.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

public class iSelectorCombine: UIView {
    
    // MARK: - Init
    
    init() {
        super.init(frame: CGRect.zero)
        view_deploy()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        view_deploy()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view_deploy()
    }
    
    /** 初始化 */
    public func view_deploy() {
        clipsToBounds = true
    }
    
    // MARK: - Size
    
    override public var frame: CGRect {
        didSet{
            if frame.size != oldValue.size {
                view_bounds()
            }
        }
    }
    override public var bounds: CGRect {
        didSet {
            if bounds.size != oldValue.size {
                view_bounds()
            }
        }
    }
    
    /** 大小变化 */
    public func view_bounds() {
        var w = bounds.width
        spaces.forEach({ w -= $0.bounds.width })
        w += (spaces.last?.bounds.width ?? 0)
        w /= CGFloat(select_ratio.count(value: { $0 }))
        
        var x: CGFloat = 0
        for i in 0 ..< selectors.count {
            let select = selectors[i]
            let space  = spaces[i]
            select.frame = CGRect(
                x: x, y: 0,
                width: select_ratio[i] * w,
                height: bounds.height
            )
            x += select.frame.width
            space.frame = CGRect(
                x: x, y: 0,
                width: space.frame.width,
                height: bounds.height
            )
            x += space.frame.width
        }
    }
    
    // MARK: - Value
    
    var date: Date = Date()
    
    func reload_date() -> Date {
        return date
    }
    
    var gradient_color: UIColor = UIColor.white {
        didSet {
            for selector in selectors {
                selector.gradient_color = gradient_color
            }
        }
    }
    
    // MARK: - Selecter
    
    var selectors: [iSelector]  = []
    var select_ratio: [CGFloat] = []
    var spaces: [UILabel]       = []
    var label: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        return view
    }()
    
    func update_label() {
        for selector in selectors {
            selector.label = label
            selector.reload()
        }
    }
    
    func update_space() {
        for space in spaces {
            space.font = label.font
            space.textAlignment = label.textAlignment
            space.textColor = label.textColor
        }
    }
    
    func update_cells(_ cells: Int) {
        for selector in selectors {
            selector.cells = cells
        }
    }
    
}

extension iSelectorCombine {
    
    public class Time: iSelectorCombine {
        
        let hour: iSelector = iSelector(direction: .vertical)
        let minute: iSelector = iSelector(direction: .vertical)
        
        // MARK: Deploy
        
        public override func view_deploy() {
            super.view_deploy()
            selectors = [hour, minute]
            select_ratio = [1,1]
            for selector in selectors {
                let space = UILabel()
                space.text = ":"
                space.textColor = UIColor.black
                space.sizeToFit()
                spaces.append(space)
                addSubview(space)
                
                selector.label = label
                selector.backgroundColor = UIColor.clear
                addSubview(selector)
            }
            
            hour.default_data = 3
            minute.default_data = 4
        }
        
        // MARK: - Value
        
        override func reload_date() -> Date {
            date = date.first(.day).addingTimeInterval(TimeInterval(hour.int * 3600 + minute.int * 60))
            return date
        }
        
    }
    
}
