//
//  BaseObject.swift
//  Weather Project
//
//  Created by Burak Uzunboy on 15.11.2018.
//  Copyright © 2018 buzunboy. All rights reserved.
//

import UIKit

public class BaseObject: NSObject {
    
    public var title: String!
    public var subtitle: String!
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }

}
