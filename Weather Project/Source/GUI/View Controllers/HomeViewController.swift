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
    private var pickerView: UIPickerView!
    private var historyObj: [CityObject]!
    private var pickerBtn: UIBarButtonItem!
    
    private var pickerToolbar: UIToolbar!
    private var keyboardToolbar: UIToolbar!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 250))
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingIndicator = LoadingView(maxRadii: 100)
        self.loadingIndicator.center = self.view.center
        self.view.addSubview(self.loadingIndicator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.historyObj = LDBModel.sharedInstance.getCities()
        (self.historyObj.count > 0) ? (pickerBtn.isEnabled = true) : (pickerBtn.isEnabled = false)
        self.pickerView.reloadAllComponents()
    }
    
    override func prepareUI() {
        let historyBtn = UIBarButtonItem(title: "History", style: .done, target: self, action: #selector(historyBtnClicked))
        self.navigationItem.rightBarButtonItem = historyBtn
        
        keyboardToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 36))
        pickerBtn = UIBarButtonItem(title: "Recents", style: .done, target: self, action: #selector(openPicker))
        let flexBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClicked))
        keyboardToolbar.barStyle = .default
        keyboardToolbar.setItems([pickerBtn, flexBtn, doneBtn], animated: true)
        
        pickerToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 36))
        pickerToolbar.barStyle = .default
        let pickerDoneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closePicker))
        let keyboardBtn = UIBarButtonItem(title: "Open Keyboard", style: .done, target: self, action: #selector(returnToKeyboard))
        pickerToolbar.setItems([keyboardBtn, flexBtn, pickerDoneBtn], animated: true)
        
        self.searchTF.inputAccessoryView = keyboardToolbar
    }
    
    @objc private func openPicker() {
        self.searchTF.resignFirstResponder()
        self.searchTF.inputView = pickerView
        self.searchTF.inputAccessoryView = pickerToolbar
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.searchTF.becomeFirstResponder()
        }
    }
    
    @objc private func doneClicked() {
        self.searchTF.resignFirstResponder()
    }
    
    @objc private func returnToKeyboard() {
        self.searchTF.resignFirstResponder()
        self.searchTF.inputView = nil
        self.searchTF.inputAccessoryView = keyboardToolbar
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.searchTF.becomeFirstResponder()
        }
    }
    
    @objc private func closePicker() {
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
        WeatherModel.sharedInstance.getForecast(ofCity: text) { (city) in
            self.loadingIndicator.stopAnimating()
            if let city = city {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CityDetailTableViewController") as! CityDetailTableViewController
                vc.initialize(city: city)
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                AlertViewModel.showAlert(title: "Error", subtitle: "Couldn't find city")
            }
        }
    }
}

extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return historyObj.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return historyObj[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.searchTF.text = historyObj[row].name
    }
    
}
