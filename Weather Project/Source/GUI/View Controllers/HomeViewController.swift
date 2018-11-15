//
//  HomeViewController.swift
//  Weather Project
//
//  Created by Burak Uzunboy on 15.11.2018.
//  Copyright © 2018 buzunboy. All rights reserved.
//

import UIKit

class HomeViewController: BaseUIViewController {

    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    
    private var loadingIndicator: LoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingIndicator = LoadingView(maxRadii: 100)
        self.loadingIndicator.center = self.view.center
        self.view.addSubview(self.loadingIndicator)
    }
    
    override func prepareUI() {
        let historyBtn = UIBarButtonItem(title: "History", style: .done, target: self, action: #selector(historyBtnClicked))
        self.navigationItem.rightBarButtonItem = historyBtn
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 36))
        let flexBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClicked))
        toolbar.barStyle = .default
        toolbar.setItems([flexBtn, doneBtn], animated: true)
        self.searchTF.inputAccessoryView = toolbar
    }
    
    @objc private func doneClicked() {
        self.searchTF.resignFirstResponder()
    }
    
    @objc private func historyBtnClicked() {
        let vc = HistoryTableViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func searchBtnClicked(_ sender: Any) {
        guard let text = self.searchTF.text,
            !text.isEmpty else {
                return
        }
        self.loadingIndicator.startAnimating()
        WeatherModel.getForecast(ofCity: text) { (city) in
            self.loadingIndicator.stopAnimating()
            if let city = city {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CityDetailTableViewController") as! CityDetailTableViewController
                vc.initialize(city: city)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
