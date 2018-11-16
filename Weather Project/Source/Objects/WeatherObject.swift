//
//  WeatherObject.swift
//  Weather Project
//
//  Created by Burak Uzunboy on 15.11.2018.
//  Copyright © 2018 buzunboy. All rights reserved.
//

import UIKit

public class WeatherObject: BaseObject {
    
    var currentTemp: Double!
    var minTemp: Double!
    var maxTemp: Double!
    var pressure: Double!
    var seaLevelPressure: Double!
    var groundLevelPressure: Double!
    var humidity: Double!
    var weatherType: String!
    var weatherTypeDescription: String!
    var cloudRate: Int!
    var windSpeed: Double!
    var windDirection: Double!
    var rainRate: Double?
    var snowRate: Double?
    var date: Date!
    
    init(from dict: [String:Any]) {
        let mainDict = dict["main"] as! [String:Any]
        let weatherDict = dict["weather"] as! [[String:Any]]
        let cloudDict = dict["clouds"] as! [String:Any]
        let windDict = dict["wind"] as! [String:Any]
        let rainDict = dict["rain"] as? [String:Any]
        let snowDict = dict["snow"] as? [String:Any]
        let dateStr = dict["dt"] as! NSNumber
        
        self.date = Date(timeIntervalSince1970: Double(truncating: dateStr))
        self.currentTemp = mainDict["temp"] as? Double
        self.minTemp = mainDict["temp_min"] as? Double
        self.maxTemp = mainDict["temp_max"] as? Double
        self.pressure = mainDict["pressure"] as? Double
        self.seaLevelPressure = mainDict["sea_level"] as? Double
        self.groundLevelPressure = mainDict["grnd_level"] as? Double
        self.humidity = mainDict["humidity"] as? Double
        
        self.weatherType = weatherDict.first?["main"] as? String
        self.weatherTypeDescription = weatherDict.first?["description"] as? String
        
        self.cloudRate = cloudDict["all"] as? Int
        
        self.windSpeed = windDict["speed"] as? Double
        self.windDirection = windDict["deg"] as? Double
        
        self.rainRate = (rainDict?["3h"] as? Double)?.roundedToNextSignficant()
        self.snowRate = (snowDict?["3h"] as? Double)?.roundedToNextSignficant()
        super.init(title: "", subtitle: "")
    }

}
