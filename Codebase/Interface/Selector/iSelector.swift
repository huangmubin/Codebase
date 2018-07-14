//
//  iSelector.swift
//  My
//
//  Created by Myron on 2018/4/24.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

/** iSelector Delegate */
public protocol i_SelectorDelegate: class {
    /** Cell when iSelector update the index */
    func i_selector(_ iSel: iSelector, update_index index: Int)
}

/** iSelector View */
public class iSelector: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - Init
    
    /**  */
    public override init(frame: CGRect) {
        super.init(frame: frame)
        view_deploy()
    }
    
    /**  */
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view_deploy()
    }
    
    /**  */
    public convenience init(direction: UICollectionViewScrollDirection) {
        self.init(frame: CGRect.zero)
        self.direction = direction
    }
    
    // MARK: - Data
    
    /** Show Data */
    public var data: [String] = []
    
    /** Current showing data */
    public var current: String { return data[index] }
    /** Current showing data's int type, error is 0 */
    public var int: Int { return Int(current) ?? 0 }
    
    /** Cell size */
    public var size: CGSize = CGSize.zero
    
    /** loop */
    public var is_loop: Bool = true
    
    // MARK: Index
    
    /** scroll view's index */
    public var index_scroll: Int {
        switch direction {
        case .vertical:
            if size.height > 0 {
                return Int(
                    collection.contentOffset.y / size.height + 0.5
                ) % data.count
            } else {
                return 0
            }
        case .horizontal:
            if size.width > 0 {
                return Int(
                    collection.contentOffset.x / size.width + 0.5
                ) % data.count
            } else {
                return 0
            }
        }
    }
    
    /** data_index */
    public var index: Int { return index_scroll }
    
    // MARK: Delegate
    
    /** IBOutlet delegate */
    @IBOutlet public weak var i_delegate: NSObject! {
        didSet {
            if let i = i_delegate as? i_SelectorDelegate {
                delegate = i
            }
        }
    }
    /** i_SelectorDelegate */
    public weak var delegate: i_SelectorDelegate?
    
    // MARK: IB
    
    /** Scroll Direction */
    @IBInspectable public var i_direction: Bool = true {
        didSet { direction = i_direction ? .vertical : .horizontal }
    }
    /** Scroll Direction */
    public var direction: UICollectionViewScrollDirection = .vertical {
        didSet {
            update_direction()
            layout.scrollDirection = direction
        }
    }
    
    /** Label */
    @IBOutlet public var label: UILabel! = nil {
        didSet {
            label.removeFromSuperview()
            collection?.reloadData()
        }
    }
    
    /** year month day hour minute */
    @IBInspectable public var default_data: Int = 0 {
        didSet {
            switch default_data {
            case 0: data = iSelector.years()
            case 1: data = iSelector.months()
            case 2: data = iSelector.days(year: Date().year, month: Date().month)
            case 3: data = iSelector.hours()
            case 4: data = iSelector.minutes()
            default: break
            }
        }
    }
    
    /** Start to end */
    @IBInspectable public var default_data2: CGSize = CGSize.zero {
        didSet {
            let s = Int(default_data2.width)
            let e = Int(default_data2.height)
            if s < e {
                data = iSelector.number(s, e)
            }
        }
    }
    
    /** 总共显示多少个单元 */
    @IBInspectable public var cells: Int = 5 {
        didSet {
            update_direction()
            reload()
        }
    }
    
    // MARK: - Gradient
    
    /** gradien view */
    private var gradient_view: UIView = UIView()
    /** gradien layer */
    private var gradient: CAGradientLayer = CAGradientLayer()
    /** gradien location */
    public var gradien_locations: [NSNumber] = [0, 0.5, 1] {
        didSet {
            gradient.locations = gradien_locations
            gradient.setNeedsDisplay()
        }
    }
    /** gradien color */
    @IBInspectable public var gradient_color: UIColor = UIColor.white {
        didSet {
            gradient.colors = [
                gradient_color.cgColor,
                UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor,
                gradient_color.cgColor
            ]
            gradient.setNeedsDisplay()
        }
    }
    
    // MARK: - Deploy
    
    /** Deploy when init */
    public func view_deploy() {
        // Laber
        if label == nil {
            label = UILabel()
            label.font = UIFont(name: "PingFangSC-Thin", size: 24)
            label.textAlignment = .center
            label.textColor = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1)
        }
        
        // Layout
        switch direction {
        case .vertical:
            size = CGSize(width: self.bounds.width, height: self.bounds.height / CGFloat(cells))
        case .horizontal:
            size = CGSize(width: self.bounds.width / CGFloat(cells), height: self.bounds.height)
        }
        
        layout.scrollDirection = direction
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        // Collection
        collection = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collection.backgroundColor = UIColor.clear
        addSubview(collection)
        
        // Gradien
        addSubview(gradient_view)
        gradient_view.frame = bounds
        gradient_view.backgroundColor = UIColor.clear
        gradient_view.isUserInteractionEnabled = false
        gradient.frame = bounds
        gradient.colors = [gradient_color.cgColor, UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor, gradient_color.cgColor]
        gradient.locations = gradien_locations
        switch direction {
        case .vertical:
            gradient.startPoint = CGPoint(x: 0.5, y: 0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1)
        case .horizontal:
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
        }
        gradient_view.layer.addSublayer(gradient)
    }
    
    // MARK: - Frame

    /**  */
    override public var frame: CGRect {
        didSet{
            if frame.size != oldValue.size {
                view_bounds()
            }
        }
    }
    /**  */
    override public var bounds: CGRect {
        didSet {
            if bounds.size != oldValue.size {
                view_bounds()
            }
        }
    }
    
    /** Update the bounds */
    public func view_bounds() {
        update_direction()
        collection.frame = bounds
        gradient_view.frame = bounds
        gradient.frame = bounds
        reload()
    }
    
    /** Update the size and gradient */
    private func update_direction() {
        layout.scrollDirection = direction
        switch direction {
        case .vertical:
            size = CGSize(width: self.bounds.width, height: self.bounds.height / CGFloat(cells))
            gradient.startPoint = CGPoint(x: 0.5, y: 0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1)
        case .horizontal:
            size = CGSize(width: self.bounds.width / CGFloat(cells), height: self.bounds.height)
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
        }
        gradient.setNeedsDisplay()
    }
    
    // MARK: - Collection
    
    /** UICollectionViewFlowLayout */
    private var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    /** UICollectionView */
    private var collection: UICollectionView!
    
    /** Reload */
    public func reload() {
        collection.reloadData()
        if is_loop {
            if data.count >= cells {
                collection.scrollToItem(
                    at: IndexPath(row: data.count - (cells / 2), section: 0),
                    at: UICollectionViewScrollPosition.top,
                    animated: false
                )
            }
        }
    }
    
    /** Scroll */
    public func scroll(data: String, animate: Bool) {
        //print("scroll \(data) collection = \(collection.contentSize)")
        if let i = self.data.index(of: data) {
            collection.scrollToItem(at: IndexPath(row: i, section: 0), at: UICollectionViewScrollPosition.top, animated: animate)
        }
    }
    
    /** Scroll */
    public func scroll(i: Int, animate: Bool) {
        if i + (cells - 1) / 2 <= data.count {
            collection.scrollToItem(at: IndexPath(row: i, section: 0), at: UICollectionViewScrollPosition.top, animated: animate)
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if is_loop {
            return data.count * 3
        } else {
            return data.count + cells - 1
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        if cell.tag != 10 {
            let label = UILabel()
            label.tag = 100
            label.font = self.label.font
            label.textColor = self.label.textColor
            label.textAlignment = self.label.textAlignment
            cell.tag = 10
            cell.contentView.addSubview(label)
        }
        
        if let label = cell.viewWithTag(100) as? UILabel {
            label.frame = cell.bounds
            if is_loop {
                label.text = data[indexPath.row % data.count]
            } else {
                let space = (cells - 1) / 2
                if indexPath.row < space {
                    label.text = ""
                } else if indexPath.row >= data.count + space {
                    label.text = ""
                } else {
                    label.text = data[indexPath.row - space]
                }
            }
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return size
    }
    
    // MARK: - Scroll
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewDidEndDecelerating(scrollView)
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var i: Int
        switch direction {
        case .vertical:
            i = Int(scrollView.contentOffset.y / size.height + 0.5)
            scrollView.isUserInteractionEnabled = false
            scrollView.setContentOffset(
                CGPoint(x: 0, y: CGFloat(i) * size.height),
                animated: true
            )
        case .horizontal:
            i = Int(scrollView.contentOffset.x / size.width + 0.5)
            scrollView.isUserInteractionEnabled = false
            scrollView.setContentOffset(
                CGPoint(x: CGFloat(i) * size.width, y: 0),
                animated: true
            )
        }
        if is_loop {
            i = i % data.count + data.count
            var point: CGPoint
            switch direction {
            case .vertical:
                point = CGPoint(x: 0, y: CGFloat(i) * size.height)
            case .horizontal:
                point = CGPoint(x: CGFloat(i) * size.width, y: 0)
            }
            DispatchQueue.main.delay(time: 0.5, execute: {
                switch self.direction {
                case .vertical:
                    scrollView.setContentOffset(point, animated: false)
                case .horizontal:
                    scrollView.setContentOffset(point, animated: false)
                }
                scrollView.isUserInteractionEnabled = true
            })
        } else {
            scrollView.isUserInteractionEnabled = true
        }
        delegate?.i_selector(self, update_index: i)
    }
    
}

// MARK: - Datas

extension iSelector {
    
    /** Date format */
    static let format = DateFormatter()
    
    // MARK: - Days
    
    /** Number Datas */
    static public func number(_ s: Int, _ e: Int) -> [String] {
        var strs = [String]()
        for i in s ... e {
            strs.append("\(i)")
        }
        return strs
    }
    
    /** 1 ... 12 */
    static func months() -> [String] {
        return number(1, 12)
    }
    
    /** 2010 ... 2100 */
    static func years() -> [String] {
        return number(2010, 2100)
    }
    
    /** Days */
    static func days(year: Int, month: Int) -> [String] {
        format.dateFormat = "yyyy-M-d"
        var strs = [String]()
        if let date = format.date(from: "\(year)-\(month)-1") {
            for i in 1 ... date.days(.month) {
                strs.append("\(i)")
            }
        }
        return strs
    }
    
    /** 0 ... 23 */
    static func hours() -> [String] {
        return number(0, 23)
    }
    
    /** 0 ... 59 */
    static func minutes() -> [String] {
        return number(0, 59)
    }
    
}

