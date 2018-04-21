//
//  TableCards.swift
//  My
//
//  Created by Myron on 2018/4/20.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

// MARK: - Cards

extension TableCards {
    public class Cards {
        public var identifier: String = ""
        public weak var cell: TableCardsCell?
        public var height: CGFloat = 80
    }
}

/** 用于控制多个 Cell，并且可控出现的 TableView */
public class TableCards: TableView, UITableViewDataSource, UITableViewDelegate {
    
    public weak var controller: ViewController!
    
    // MARK: - Cards
    
    /** Cell 对象，初始化时要求进行设置 */
    public var cards: [TableCards.Cards] = []
    
    /** 获取标识符 */
    public func identifier(_ index: IndexPath) -> String {
        return cards[index.row].identifier
    }
    
    /** 获取高度 */
    public func height(_ index: IndexPath) -> CGFloat {
        return cards[index.row].height
    }
    
    // MARK: - Cell
    
    /** 获取并缓存 Cell */
    public func cell(_ index: IndexPath) -> TableCardsCell {
        if let cell = cards[index.row].cell {
            cell.view_update(index: index, controller: controller)
            return cell
        } else {
            let cell = self.dequeueReusableCell(withIdentifier: cards[index.row].identifier, for: index) as! TableCardsCell
            cell.view_update(index: index, controller: controller)
            cards[index.row].cell = cell
            return cell
        }
    }
    
    // MARK: - UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cell(indexPath)
    }
    
    // MARK: - UITableViewDelegate
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height(indexPath)
    }
    
}
