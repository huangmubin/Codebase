//
//  CollectionView.swift
//  Days
//
//  Created by 黄穆斌 on 2018/5/24.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

public class CollectionView: UICollectionView {
    
    /***/
    weak var vc: ViewController?
    
    // MARK: - Layout
    
    /** Layout */
    weak var layout: UICollectionViewLayout?
    /** Layout */
    var flow: UICollectionViewFlowLayout? { return layout as? UICollectionViewFlowLayout }
    
    // MARK: - Deploy
    
    convenience init() {
        let flow = UICollectionViewFlowLayout()
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        self.init(frame: CGRect.zero, collectionViewLayout: flow)
        self.layout = flow
    }
    
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        view_deploy()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view_deploy()
    }
    
    /** 初始化 */
    public func view_deploy() { }
    
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
    public func view_bounds() { }
    
    
}
