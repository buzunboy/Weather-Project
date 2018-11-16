//
//  CityDetailTableViewController.swift
//  Weather Project
//
//  Created by Burak Uzunboy on 15.11.2018.
//  Copyright © 2018 buzunboy. All rights reserved.
//

import UIKit

class CityDetailTableViewController: UITableViewController {
    
    private static let coverCellIdentifier = "coverCell"
    private static let weatherCellIdentifier = "weatherCell"
    private var weatherList: [WeatherObject]!
    private var selectedCity: CityObject!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareUI()
    }
    
    public func initialize(city: CityObject) {
        self.navigationItem.title = city.name
        self.selectedCity = city
        if let data = city.weatherData {
            self.weatherList = data
        } else {
            self.weatherList = [WeatherObject]()
        }
        self.tableView.reloadData()
    }
  
    
    public func reloadCityInfo(city: CityObject, completion: @escaping (_ loaded: Bool)->()) {
        self.selectedCity = city
        WeatherModel.sharedInstance.getForecast(ofCity: self.selectedCity.name) { (object) in
            if let object = object {
                self.initialize(city: object)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func prepareUI() {
        if #available(iOS 11, *) {
            self.navigationItem.largeTitleDisplayMode = .always
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Hourly Weather Forecast"
        }
        
        return nil
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return weatherList.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherDetailTableViewController")
            (vc as! WeatherDetailTableViewController).initialize(weather: weatherList[indexPath.row], cityName: selectedCity.name)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 285
        } else {
            return 50
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if selectedCity != nil {
                let cell = tableView.dequeueReusableCell(withIdentifier: CityDetailTableViewController.coverCellIdentifier,
                                                         indexPath: indexPath, object: selectedCity)
                return cell
            } else {
                return UITableViewCell()
            }
        } else {
            return tableView.dequeueReusableCell(withIdentifier: CityDetailTableViewController.weatherCellIdentifier,
                                                 indexPath: indexPath,
                                                 object: self.weatherList[indexPath.row])
        }
    }

}
