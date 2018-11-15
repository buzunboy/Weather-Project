//
//  WeatherModel.swift
//  Weather Project
//
//  Created by Burak Uzunboy on 15.11.2018.
//  Copyright © 2018 buzunboy. All rights reserved.
//

import Foundation

/**
 Controls forecast of the cities by fetching from the **OpenWeatherMap API**.
 */
public class WeatherModel {
    
    fileprivate static let apiUrl = "http://api.openweathermap.org/data/2.5/forecast"
    fileprivate static let appIdentifier = "8827fbf408dc7e1418f3c1e84596334c"
    
    /**
     Fetches forecast of the specified city
     - parameter city: Name of the city.
     - parameter completion: Returns fetch result of the specified city.
     - parameter result: **CityObject** if fetches successfuly, *nil* otherwise.
    */
    public static func getForecast(ofCity city: String, completion: @escaping (_ result: CityObject?)->()) {
        var urlComponents = URLComponents(url: URL(string: apiUrl)!, resolvingAgainstBaseURL: false)!
        let cityName = URLQueryItem(name: "q", value: city)
        let units = URLQueryItem(name: "units", value: "metric")
        let appId = URLQueryItem(name: "APPID", value: appIdentifier)
        
        urlComponents.queryItems = [cityName, units, appId]
        executeRequest(urlComponents.url!.absoluteURL) { (error, result) in
            if let error = error {
                NSLog("Couldn't get forecast for func: \(#function) - Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let result = result as? [String:Any] {
                if let city = CityObject(with: result) {
                    completion(city)
                    if LDBModel.sharedInstance.saveCity(city) {
                        NSLog("City successfuly saved to the Local Database - ID: \(city.id!)")
                    } else {
                        NSLog("Couldn't save city to the Local Database with ID: \(city.id!)")
                    }
                } else {
                    completion(nil)
                }
            } else {
                NSLog("Couldn't convert result to expected dictionary")
                completion(nil)
            }
        }
    }
    
    /**
     Executes URL request with **GET** method
     - parameter withURL: URL which will be requested.
     - parameter completion: Response of the request.
     - parameter error: Nil if successfuly responded.
     - parameter result: Response of the request if operation is completed successfuly, *nil* otherwise.
    */
    private static func executeRequest(_ withURL: URL, completion: @escaping (_ error: Error?, _ result: Any?)->()) {
        
        DispatchQueue.global().async {
            
            var request = URLRequest(url: withURL)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    let err = NSError(description: "Error occured during task - Error: \(error.localizedDescription)")
                    completion(err, nil)
                    return
                }
                if let response = response {
                    let httpResp = response as! HTTPURLResponse
                    
                    if httpResp.statusCode < 300 && httpResp.statusCode >= 200 {
                        if data != nil {
                            guard let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions(rawValue: 0))
                                else {
                                    DispatchQueue.main.async {
                                        let err = NSError(description: "Couldn't prepare json from response")
                                        completion(err, nil)
                                    }
                                    return
                            }
                            DispatchQueue.main.async {
                                completion(nil, json)
                            }
                        } else {
                            DispatchQueue.main.async {
                                let err = NSError(description: "No data found in the response with response code: \(httpResp.statusCode)")
                                completion(err, nil)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let err = NSError(description: HTTPURLResponse.localizedString(forStatusCode: httpResp.statusCode))
                            completion(err, nil)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        let err = NSError(description: "No response is received")
                        completion(err, nil)
                    }
                }
                
            }
            task.resume()
        }
        
    }
    
}
