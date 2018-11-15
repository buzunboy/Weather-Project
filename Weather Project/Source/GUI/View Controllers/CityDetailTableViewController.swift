//
//  CityDetailTableViewController.swift
//  Mobven Interview Project
//
//  Created by Burak Uzunboy on 15.11.2018.
//  Copyright © 2018 buzunboy. All rights reserved.
//

import UIKit

class CityDetailTableViewController: BaseUITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func initialize(city: CityObject) {
        self.navigationItem.title = city.name
    }
    
    override func prepareUI() {
        if #available(iOS 11, *) {
            self.navigationItem.largeTitleDisplayMode = .always
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

}
