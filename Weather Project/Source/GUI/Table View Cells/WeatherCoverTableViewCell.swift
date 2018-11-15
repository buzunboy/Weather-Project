//
//  WeatherCoverTableViewCell.swift
//  Weather Project
//
//  Created by Burak Uzunboy on 15.11.2018.
//  Copyright © 2018 buzunboy. All rights reserved.
//

import UIKit

class WeatherCoverTableViewCell: BaseUITableViewCell {

    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var weatherDetailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func initialize(withObject object: BaseObject) {
        guard let object = object as? WeatherObject else {
            return
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM HH:mm"
        self.dateLabel.text = "\(formatter.string(from: object.date))"
        self.currentTempLabel.text = "\(String(describing: object.currentTemp!)) ℃"
        self.weatherDetailLabel.text = "\(String(describing: object.weatherTypeDescription!))"

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
