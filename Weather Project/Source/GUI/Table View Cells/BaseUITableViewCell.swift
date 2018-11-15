//
//  BaseUITableViewCell.swift
//  Weather Project
//
//  Created by Burak Uzunboy on 15.11.2018.
//  Copyright © 2018 buzunboy. All rights reserved.
//

import UIKit

class BaseUITableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    init() {
        super.init(style: .subtitle, reuseIdentifier: "default")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initialize(withObject object: BaseObject) {
        
    }
    
    func initialize(title: String, subtitle: String) {
        self.textLabel?.text = title
        self.detailTextLabel?.text = subtitle
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
