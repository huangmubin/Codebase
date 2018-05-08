//
//  ViewController.swift
//  TestSwift
//
//  Created by Myron on 2018/4/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class IViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let v = CalendarView.load(nib: nil) {
            v.frame = CGRect(x: 0, y: 50, width: view.bounds.width, height: 500)
            view.addSubview(v)
        }
    }
    
}

