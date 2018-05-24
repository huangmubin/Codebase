//
//  CollectionView.swift
//  Days
//
//  Created by 黄穆斌 on 2018/5/24.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

public class CollectionView: UICollectionView {
    
    // MARK: - Layout
    
    /** Layout */
    weak var layout: UICollectionViewLayout?
    /** Layout */
    var flow: UICollectionViewFlowLayout? { return layout as? UICollectionViewFlowLayout }
    
}
