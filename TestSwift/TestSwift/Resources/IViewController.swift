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
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UITextView.view.backgroundColor = UIColor.darkGray
        UITextView.view.frame = CGRect(
            x: 0, y: 100,
            width: 200,
            height: 50
        )
        view.addSubview(UITextView.view)
        UITextView.view.text = "Do any additional setup after loading the view, typically from a nib."
        print("height = \(UITextView.view.bounds.height); width = \(UITextView.view.bounds.width);")
        print("contentSize height = \(UITextView.view.contentSize.height); width = \(UITextView.view.contentSize.width);")
        UITextView.view.sizeThatFits(CGSize(width: 200, height: 50))
        print("height = \(UITextView.view.bounds.height); width = \(UITextView.view.bounds.width);")
        print("contentSize height = \(UITextView.view.contentSize.height); width = \(UITextView.view.contentSize.width);")
        
        let label = UILabel(frame: CGRect(
            x: 0, y: 300,
            width: 200,
            height: 50
        ))
        label.font = UITextView.view.font
        view.addSubview(label)
        label.numberOfLines = 0
        label.text = "Do any additional setup after loading the view, typically from a nib."
        label.sizeToFit()
        print("label height = \(label.bounds.height); width = \(label.bounds.width);")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

