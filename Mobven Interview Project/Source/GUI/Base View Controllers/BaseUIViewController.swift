//
//  BaseUIViewController.swift
//  Mobven Interview Project
//
//  Created by Burak Uzunboy on 15.11.2018.
//  Copyright © 2018 buzunboy. All rights reserved.
//

import UIKit

class BaseUIViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareUI()
        NSLog("\(className) did load")
    }
    
    func prepareUI() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NSLog("\(className) will be appeared")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NSLog("\(className) will be disappeared")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NSLog("\(className) did appear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NSLog("\(className) did disappear")
    }


}
