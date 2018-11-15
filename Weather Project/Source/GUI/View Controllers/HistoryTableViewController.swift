//
//  HistoryTableViewController.swift
//  Weather Project
//
//  Created by Burak Uzunboy on 16.11.2018.
//  Copyright © 2018 buzunboy. All rights reserved.
//

import UIKit

class HistoryTableViewController: BaseUITableViewController {
    
    private var loadingIndicator: LoadingView!
    
    override init() {
        super.init()
        self.tableList = LDBModel.sharedInstance.getCities()
        self.loadingIndicator = LoadingView(maxRadii: 100)
        self.loadingIndicator.center = self.view.center
        self.view.addSubview(self.loadingIndicator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.loadingIndicator.startAnimating()
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CityDetailTableViewController") as! CityDetailTableViewController
        vc.reloadCityInfo(city: (tableList[indexPath.row] as! CityObject)) { (loaded) in
            self.loadingIndicator.stopAnimating()
            if loaded {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
