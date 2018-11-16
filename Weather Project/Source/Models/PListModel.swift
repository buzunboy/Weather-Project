//
//  PListModel.swift
//  Weather Project
//
//  Created by Burak Uzunboy on 16.11.2018.
//  Copyright © 2018 buzunboy. All rights reserved.
//

import Foundation

/**
 Reads .plist files and updates them if version is changed
 - Since: 16.11.2018
 */
class PListModel {
    
    private var listName: String!
    
    /**
     Initializes with the given plist name.
    */
    init(listName: String) {
        self.listName = listName
    }

    /**
     Loades Plist file in the device directory
     - returns: NSDictionary if it can read successfuly
    */
    public func loadProperties() -> NSDictionary? {
        let path = openProperties()
        if path != nil {
            if let propertyDict = NSDictionary(contentsOfFile: path!) {
                if !self.checkVersion(propertyDict: propertyDict) {
                    let newPath = openProperties()
                    if let newDict = NSDictionary(contentsOfFile: newPath!) {
                        return newDict
                    }
                }
                return propertyDict
            }
        } else {
            NSLog("Couldn't load \(listName!).plist file")
        }
        return nil
    }
    
    /**
     Checks version of the plist in the device directory and the project directory.
     If versions are different removes one in the device directory and updates it with the
     project directory.
     - parameter propertyDict: NSDictionary file in the device directory
     - returns: **true** if versions are same, **false** otherwise
    */
    private func checkVersion(propertyDict: NSDictionary) -> Bool {
        let version = propertyDict["version"] as? NSNumber ?? NSNumber(integerLiteral: 0)
        let bundlePlistPath = Bundle.main.path(forResource: listName, ofType: ".plist")!
        let dict = NSDictionary(contentsOfFile: bundlePlistPath)!
        let bundleVersion = dict["version"] as? NSNumber ?? NSNumber(integerLiteral: 0)
        if version != bundleVersion {
            let fileManager = FileManager.default
            let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let fullDestPath = NSURL(fileURLWithPath: destPath).appendingPathComponent("\(listName!).plist")
            let fullDestPathString = fullDestPath!.path
            if fileManager.fileExists(atPath: fullDestPathString) {
                try! fileManager.removeItem(atPath: fullDestPathString)
                return false
            }
        }
        return true
    }
    
    /**
     Returns path of the plist file in the device directory
     - returns: Destination path of the device directory
    */
    private func openProperties() -> String? {
        let bundlePath = Bundle.main.path(forResource: listName, ofType: ".plist")
        let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileManager = FileManager.default
        let fullDestPath = NSURL(fileURLWithPath: destPath).appendingPathComponent("\(listName!).plist")
        let fullDestPathString = fullDestPath!.path
        if fileManager.fileExists(atPath: fullDestPathString) {
        } else {
            do {
                try fileManager.copyItem(atPath: bundlePath!, toPath: fullDestPathString)
            } catch {
                NSLog("\(listName!).plist couldn't copy to the device directory - Error: \(error.localizedDescription)")
            }
        }
        return fullDestPathString
    }
    
}
