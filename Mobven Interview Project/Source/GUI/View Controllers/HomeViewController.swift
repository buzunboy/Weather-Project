//
//  HomeViewController.swift
//  Mobven Interview Project
//
//  Created by Burak Uzunboy on 15.11.2018.
//  Copyright © 2018 buzunboy. All rights reserved.
//

import UIKit

class HomeViewController: BaseUIViewController {

    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareUI() {
        let historyBtn = UIBarButtonItem(title: "History", style: .done, target: self, action: #selector(historyBtnClicked))
        self.navigationItem.rightBarButtonItem = historyBtn
    }
    
    @objc private func historyBtnClicked() {
        let vc = BaseUITableViewController()
        vc.tableList = LDBModel.sharedInstance.getCities()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func searchBtnClicked(_ sender: Any) {
        guard let text = self.searchTF.text,
            !text.isEmpty else {
                return
        }
        WeatherModel.getForecast(ofCity: text) { (city) in
            if let city = city {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CityDetailTableViewController") as! CityDetailTableViewController
                vc.initialize(city: city)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
