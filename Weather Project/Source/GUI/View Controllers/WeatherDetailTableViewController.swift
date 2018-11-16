//
//  WeatherDetailTableViewController.swift
//  Weather Project
//
//  Created by Burak Uzunboy on 15.11.2018.
//  Copyright © 2018 buzunboy. All rights reserved.
//

import UIKit

class WeatherDetailTableViewController: BaseUITableViewController {
    
    private static let coverCellIdentifier = "weatherCover"
    private static let detailCellIdentifier = "weatherDetailCell"
    
    private var object: WeatherObject!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareUI() {
    }
    
    public func initialize(weather: WeatherObject, cityName: String) {
        self.object = weather
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, HH:mm"
        let dateStr = formatter.string(from: weather.date)
        self.navigationItem.title = dateStr
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 110
        }
        
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDetailTableViewController.coverCellIdentifier,
                                                     indexPath: indexPath, object: self.object)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDetailTableViewController.detailCellIdentifier,
                                                     for: indexPath) as! WeatherDetailTableViewCell
            
            if indexPath.row == 1 {
                cell.titleLabel.text = "Min. Temperature"
                cell.detailLabel.text = String(describing: object.minTemp!)
            }
            else if indexPath.row == 2 {
                cell.titleLabel.text = "Max. Temperature"
                cell.detailLabel.text = String(describing: object.maxTemp!)
            }
            else if indexPath.row == 3 {
                cell.titleLabel.text = "Pressure"
                cell.detailLabel.text = "\(String(describing: object.pressure!)) hPa"
            }
            else if indexPath.row == 4 {
                cell.titleLabel.text = "Sea Level Pressure"
                cell.detailLabel.text = "\(String(describing: object.seaLevelPressure!)) hPa"
            }
            else if indexPath.row == 5 {
                cell.titleLabel.text = "Ground Level Pressure"
                cell.detailLabel.text = "\(String(describing: object.groundLevelPressure!)) hPa"
            }
            else if indexPath.row == 6 {
                cell.titleLabel.text = "Humidity"
                cell.detailLabel.text = "\(String(describing: object.humidity!))%"
            }
            else if indexPath.row == 7 {
                cell.titleLabel.text = "Cloudiness"
                cell.detailLabel.text = "\(String(describing: object.cloudRate!))%"
            }
            else if indexPath.row == 8 {
                cell.titleLabel.text = "Wind Speed"
                cell.detailLabel.text = "\(String(describing: object.windSpeed!)) meter/sec"
            }
            else if indexPath.row == 9 {
                cell.titleLabel.text = "Wind Direction"
                cell.detailLabel.text = "\(String(describing: object.windDirection!)) deg."
            }
            else if indexPath.row == 10 {
                cell.titleLabel.text = "Rain Volume"
                cell.detailLabel.text = "\(String(describing: object.rainRate ?? 0.0)) mm"
            }
            else if indexPath.row == 11 {
                cell.titleLabel.text = "Snow Volume"
                cell.detailLabel.text = "\(String(describing: object.snowRate ?? 0.0)) mm"
            }
            
            return cell
        }
        
    }

}
