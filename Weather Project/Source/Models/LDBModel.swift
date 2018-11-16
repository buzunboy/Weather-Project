//
//  LDBModel.swift
//  Weather Project
//
//  Created by Burak Uzunboy on 15.11.2018.
//  Copyright © 2018 buzunboy. All rights reserved.
//

import Foundation
import CoreData

/**
 Local Database Model. Stores objects to the LDB.
 - Since: 15.11.2018
 */
public class LDBModel {
    
    /**
     Singleton instance of the Local Database Model.
     */
    public static let sharedInstance = LDBModel()
    
    private var request: NSFetchRequest<NSFetchRequestResult>!
    
    private init() {
        
    }
    
    /**
     Returns cities saved to the Local Database
     - returns: City Object Array sorted by latest fetch dates. Only name and identifier is saved.
     Do not use other properties before fetch from WeatherModel.
     */
    public func getCities() -> [CityObject] {
        var retVal = [CityObject]()
        let context = appDelegateEntity.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let resultID = result.value(forKey: "id") as? Int,
                        let name = result.value(forKey: "name") as? String,
                        let date = result.value(forKey: "date") as? Date {
                        let obj = CityObject(id: resultID, name: name, date: date)
                        retVal.append(obj)
                    }
                }
            }
        } catch {
            NSLog("Couldn't fetch results for \(#function) - Error: \(error.localizedDescription)")
        }
        
        retVal.sort(by: { $0.latestFetchDate > $1.latestFetchDate })
        return retVal
    }
    
    /**
     Saves city's name and identifier to the Local Database
     - parameter city: **CityObject** which will be saved to the Local Database
     - returns: **true** if save operation completed successfuly, **false** otherwise.
     */
    public func saveCity(_ city: CityObject) -> Bool {
        var retVal = false
        var isSavedBefore = false
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        request.returnsObjectsAsFaults = false
        
        let context = appDelegateEntity.persistentContainer.viewContext
        
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let resultID = result.value(forKey: "id") as? Int {
                        if resultID == city.id {
                            result.setValue(city.name, forKey: "name")
                            result.setValue(city.latestFetchDate, forKey: "date")
                            isSavedBefore = true
                        }
                    }
                }
            }
        } catch {
            retVal = false
            NSLog("Couldn't fetch results for \(#function) - Id: \(city.id!) - Error: \(error.localizedDescription)")
        }
        
        if !isSavedBefore {
            let obj = NSEntityDescription.insertNewObject(forEntityName: "City", into: context)
            obj.setValue(city.id, forKey: "id")
            obj.setValue(city.name, forKey: "name")
            obj.setValue(city.latestFetchDate, forKey: "date")
        }
        
        if context.hasChanges {
            do {
                try context.save()
                retVal = true
            } catch {
                retVal = false
                NSLog("Couldn't save results for \(#function) - Id: \(city.id!) - Error: \(error.localizedDescription)")
            }
        }
        
        return retVal
    }
    
    
}
