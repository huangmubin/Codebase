//
//  CalendarCollection.swift
//  Days
//
//  Created by Myron on 2018/6/22.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

extension CalendarView {
    
    public class Collection: CollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
        /**  */
        public weak var calendar: CalendarView?
        
        // MARK: - Values
        
        /**  */
        public var date: Date {
            get { return calendar?.date ?? Date() }
            set { calendar?.date = newValue }
        }
        
        /**  */
        public var identifier: String = "Cell"
        
        /**  */
        public var selecting: CalendarView.Collection.Cell!
        
        /**  */
        public var size: CGSize = CGSize(
            width: (UIScreen.main.bounds.width - 40) / 7,
            height: (UIScreen.main.bounds.width - 40) / 7
        )
        
        // MARK: - Action
        
        /**  */
        public func update(cell: CalendarView.Collection.Cell, index: IndexPath) {
            cell.date = date.first(.month).first(.weekday).advance(.day, index.row)
            cell.is_month  = (cell.date.month == date.month)
            cell.is_select = (cell.is_month && cell.date.day == date.day)
            if cell.is_select { selecting = cell }
            cell.view_reload()
            calendar?.delegate?.calendar(
                view: calendar!,
                update: cell,
                index: index
            )
        }
        // MARK: - Deploy
        
        public override func view_deploy() {
            super.view_deploy()
            dataSource = self
            delegate = self
            isScrollEnabled = false
            register(
                CalendarView.Collection.Cell.self,
                forCellWithReuseIdentifier: identifier
            )
        }
        
        // MARK: - Size
        
        public override func view_bounds() {
            super.view_bounds()
            size = CGSize(
                width: bounds.width / 7,
                height: bounds.width / 7
            )
            reloadData()
        }
        
        // MARK: - UICollectionViewDataSource
        
        public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 42
        }
        
        public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CalendarView.Collection.Cell
            cell.view_update(index: indexPath, view: self)
            update(cell: cell, index: indexPath)
            return cell
        }
        
        // MARK: - UICollectionViewDelegateFlowLayout
        
        public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            date = date.first(.month).first(.weekday).advance(.day, indexPath.row)
            if let cell = selecting {
                update(cell: cell, index: cell.index)
            }
            if let cell = collectionView.cellForItem(at: indexPath) as? CalendarView.Collection.Cell {
                update(cell: cell, index: indexPath)
            }
        }
        
        public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return size
        }
        
        public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
        }
    }
    
}

// MARK: - Cell

extension CalendarView.Collection {
    
    public class Cell: CollectionViewCell {
        
        // MARK: - UI
        
        public class Color {
            static var dark: UIColor = UIColor(30,30,30,1)
            static var light: UIColor = UIColor(100,100,100,1)
            static var thin: UIColor = UIColor(240,240,240,1)
            static var non: UIColor = UIColor(255,255,255,1)
        }
        
        // MARK: - Values
        
        public var date: Date = Date()
        public var is_month: Bool = false
        public var is_select: Bool = false
        
        // MARK: - Sub Views
        
        let back: View = View(corner: 2)
        let flag: View = View(corner: 1)
        let info: UILabel = {
            let label = UILabel()
            label.isUserInteractionEnabled = true
            label.textColor = UIColor(30,30,30,1)
            label.font = UIFont(name: "PingFangSC-Regular", size: 18)!
            label.textAlignment = .center
            label.sizeToFit()
            return label
        }()
        
        // MARK: - Load
        
        override public func view_load() {
            super.view_load()
            addSubview(back)
            addSubview(flag)
            addSubview(info)
        }
        
        override public func view_reload() {
            super.view_reload()
            info.text = date.day.description
            info.textColor = is_month ? Color.dark : Color.thin
            flag.backgroundColor = is_select ? Color.dark : Color.non
            view_bounds()
        }
        
        public override func view_bounds() {
            super.view_bounds()
            back.frame = CGRect(
                x: 1, y: 1,
                width: bounds.width - 2,
                height: bounds.height - 2
            )
            back.corner = back.bounds.width * 0.2
            flag.frame = CGRect(
                x: 8,
                y: bounds.height * 0.8,
                width: bounds.width - 16,
                height: 2
            )
            info.frame = back.frame
        }
        
        public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
        }
        
    }
    
}
