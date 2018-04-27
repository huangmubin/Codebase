//
//  TableCardsCell.swift
//  My
//
//  Created by Myron on 2018/4/20.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

/** Table Cards 专用 Cell 父类 */
public class TableCardsCell: TableViewCell {
    
    /** 指向自己的单元数据 */
    public weak var card: TableCards.Cards!
    /** 指向自己的 Table */
    public weak var table: TableCards!
    
    
}
