//
//  TableViewExt.swift
//  Mobven Interview Project
//
//  Created by Burak Uzunboy on 15.11.2018.
//  Copyright © 2018 buzunboy. All rights reserved.
//

import UIKit

extension UITableView {
    
    func dequeueReusableCell(withIdentifier identifier: String, indexPath: IndexPath, object: BaseObject) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        (cell as? BaseUITableViewCell)?.initialize(withObject: object)
        return cell
    }
    
}
