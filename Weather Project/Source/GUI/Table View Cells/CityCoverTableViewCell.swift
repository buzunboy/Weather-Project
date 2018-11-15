//
//  CityCoverTableViewCell.swift
//  Weather Project
//
//  Created by Burak Uzunboy on 15.11.2018.
//  Copyright © 2018 buzunboy. All rights reserved.
//

import UIKit

class CityCoverTableViewCell: BaseUITableViewCell {

    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var coordinateLabel: UILabel!
    @IBOutlet weak var populationAndCountryLabel: UILabel!
    
    private var selectedCity: CityObject!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func initialize(withObject object: BaseObject) {
        guard let city = object as? CityObject else {
            fatalError("Couldn't cast BaseObject to CityObject")
        }
        
        self.selectedCity = city
        self.coordinateLabel.text = "\(city.coordinate!.0), \(city.coordinate!.1)"
        let populationStr = String(describing: city.population!)
        self.populationAndCountryLabel.text = "Population: \(populationStr) (\(city.country!))"
        if let data = city.weatherData {
            self.prepareChart(with: data)
        }
    }
    
    func prepareChart(with data: [WeatherObject]) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<data.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(data[i].currentTemp))
            dataEntries.append(dataEntry)
        }
        
        let dataCount = data.count
        if dataCount > 10 {
            dataEntries.removeLast(dataCount-10)
        }
        chartView.dragEnabled = false
        chartView.drawGridBackgroundEnabled = false
        chartView.chartDescription?.text = ""
        chartView.legend.enabled = false
        chartView.xAxis.enabled = false
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        
        let chartDataSet = LineChartDataSet(values: dataEntries, label: "Temperature")
        chartDataSet.lineDashLengths = [5, 2.5]
        chartDataSet.highlightLineDashLengths = [5, 2.5]
        chartDataSet.setColor(.black)
        chartDataSet.setCircleColor(.black)
        chartDataSet.lineWidth = 1
        chartDataSet.circleRadius = 3
        chartDataSet.drawCircleHoleEnabled = false
        chartDataSet.valueFont = .systemFont(ofSize: 9)
        chartDataSet.formLineDashLengths = [5, 2.5]
        chartDataSet.formLineWidth = 1
        chartDataSet.formLineWidth = 15
        chartDataSet.mode = .horizontalBezier
        chartDataSet.drawHorizontalHighlightIndicatorEnabled = false
        var color0: UIColor!
        var color1: UIColor!
        color0 = UIColor.white
        color1 = UIColor.green

        let gradientColors = [color0.cgColor,
                              color1.cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        chartDataSet.fillAlpha = 1
        chartDataSet.fill = Fill(linearGradient: gradient, angle: 90) //.linearGradient(gradient, angle: 90)
        chartDataSet.drawFilledEnabled = true
        let lineData = LineChartData(dataSet: chartDataSet)

        chartView.data = lineData
        chartView.reloadInputViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
