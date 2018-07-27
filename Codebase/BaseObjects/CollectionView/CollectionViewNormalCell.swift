//
//  CollectionViewNormalCell.swift
//  Days3
//
//  Created by Myron on 2018/7/27.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

public class CollectionViewNormalCell: CollectionViewCell {
    
    public let info: UILabel = UILabel()
    
    public override func view_load() {
        super.view_load()
        addSubview(info)
        info.textAlignment = .center
        info.frame = bounds
    }
    
    public override func view_bounds() {
        super.view_bounds()
        info.frame = bounds
    }
    
}
