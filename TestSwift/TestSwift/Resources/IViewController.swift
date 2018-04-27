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
        let aa: [CGFloat] = [0,1,2,3,4,5]
        print(aa.count(value: { $0 }))
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        DispatchQueue.global().async {
//            Thread.sleep(forTimeInterval: 0.5)
//            DispatchQueue.main.async {
//                if let v = InputTextView.load(nib: nil) {
//                    v.frame = self.view.bounds
//                    self.view.addSubview(v)
//                }
//            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

