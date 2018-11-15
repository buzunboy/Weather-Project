//
//  NSObjectExt.swift
//  Mobven Interview Project
//
//  Created by Burak Uzunboy on 15.11.2018.
//  Copyright © 2018 buzunboy. All rights reserved.
//

import UIKit

extension NSObject {
    
    /**
     * Returns name of the specified class
     */
    var className: String {
        get {
            return getOnlyClassName()
        }
    }
    
    private func getOnlyClassName() -> String {
        let describing = String(describing: self)
        if let dotIndex = describing.index(of: "."), let commaIndex = describing.index(of: ":") {
            let afterDotIndex = describing.index(after: dotIndex)
            if(afterDotIndex < commaIndex) {
                return String(describing[afterDotIndex ..< commaIndex])
            }
        }
        return describing
    }
}

