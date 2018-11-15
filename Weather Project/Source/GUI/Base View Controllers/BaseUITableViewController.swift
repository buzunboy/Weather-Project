//
//  BaseUITableViewController.swift
//  Weather Project
//
//  Created by Burak Uzunboy on 15.11.2018.
//  Copyright © 2018 buzunboy. All rights reserved.
//

import UIKit

class BaseUITableViewController: UITableViewController {
    
    public var tableList: [BaseObject]! {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    public var shouldHaveSpecialCells: Bool = false { didSet { self.tableView.reloadData() } }
    
    public var tableCellReuseIdentifier: String! = "reuseIdentifier"
    
    init() {
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareUI()
        NSLog("\(className) did load")
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
    
    public func prepareUI() {
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if shouldHaveSpecialCells { return 2 } else { return 1 }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldHaveSpecialCells {
            if section == 0 {
                return 1
            } else if section == 1 {
                return self.tableList.count
            } else {
                return 0
            }
        } else {
            if section == 0 {
                return self.tableList.count
            } else {
                return 0
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if shouldHaveSpecialCells {
            if indexPath.section == 1 {
                let cell = BaseUITableViewCell()
                cell.initialize(title: tableList[indexPath.row].title, subtitle: tableList[indexPath.row].subtitle)
                return cell
            }
        }
        
        let cell = BaseUITableViewCell()
        cell.initialize(title: tableList[indexPath.row].title, subtitle: tableList[indexPath.row].subtitle)
        return cell
    }

}
