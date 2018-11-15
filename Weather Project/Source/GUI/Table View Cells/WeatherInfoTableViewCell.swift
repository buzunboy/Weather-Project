//
//  WeatherInfoTableViewCell.swift
//  Weather Project
//
//  Created by Burak Uzunboy on 15.11.2018.
//  Copyright © 2018 buzunboy. All rights reserved.
//

import UIKit

class WeatherInfoTableViewCell: BaseUITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func initialize(withObject object: BaseObject) {
        guard let object = object as? WeatherObject else {
            fatalError("Couldn't cast BaseObject to WeatherObject")
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d @ HH:mm"
        self.timeLabel.text = "\(formatter.string(from: object.date))"
        self.tempLabel.text = "\(String(describing: object.currentTemp!)) ℃"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
