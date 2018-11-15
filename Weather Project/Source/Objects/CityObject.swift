//
//  CityObject.swift
//  Weather Project
//
//  Created by Burak Uzunboy on 15.11.2018.
//  Copyright © 2018 buzunboy. All rights reserved.
//

import UIKit

public class CityObject: BaseObject {
    
    public var name: String!
    public var id: Int!
    public var coordinate: (Float,Float)!
    public var country: String!
    public var population: Int!
    public var latestFetchDate: Date!
    
    public var weatherData: [WeatherObject]?

    public init(id: Int, name: String, date: Date) {
        super.init(title: name, subtitle: String(describing: date))
        self.latestFetchDate = date
        self.id = id
        self.name = name
    }
    
    public init(id: Int, name: String, lat: Float, lon: Float, country: String, population: Int) {
        let date = Date()
        super.init(title: name, subtitle: String(describing: date))
        self.latestFetchDate = date
        self.id = id
        self.name = name
        self.coordinate = (lat,lon)
        self.country = country
        self.population = population
    }
    
    init?(with dictionary: [String:Any]) {
        guard let cityDict = dictionary["city"] as? [String:Any],
            let name = cityDict["name"] as? String,
            let id = cityDict["id"] as? Int,
            let country = cityDict["country"] as? String,
            let coord = cityDict["coord"] as? [String:Any],
            let population = cityDict["population"] as? Int else {
                NSLog("Couldn't create City Object from dictionary - Dict: \(dictionary.debugDescription)")
                return nil
        }
        
        let date = Date()
        super.init(title: name, subtitle: String(describing: date))
        self.name = name
        self.id = id
        self.population = population
        self.country = country
        self.latestFetchDate = Date()
        let lat = (coord["lat"] as! NSNumber).floatValue
        let lon = (coord["lon"] as! NSNumber).floatValue
        self.coordinate = (lat,lon)
        if let list = dictionary["list"] as? [[String:Any]] {
            self.setWeatherData(listArray: list)
        }
    }
    
    private func setWeatherData(listArray: [[String:Any]]) {
        var weatherObjDict = [WeatherObject]()
        for item in listArray {
            let obj = WeatherObject(from: item)
            weatherObjDict.append(obj)
        }
        self.weatherData = weatherObjDict
    }

}
