//
//  NSErrorExt.swift
//  Mobven Interview Project
//
//  Created by Burak Uzunboy on 15.11.2018.
//  Copyright © 2018 buzunboy. All rights reserved.
//

import Foundation

extension NSError {
    convenience init(description: String) {
        self.init(domain: "Mobven Interview", code: 500, userInfo: [NSLocalizedDescriptionKey: description])
    }
}
