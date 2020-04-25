//
//  DetailViewController.swift
//  CryptoTop
//
//  Created by Islam on 4/24/20.
//  Copyright © 2020 Islam. All rights reserved.
//

import UIKit
import Charts

class DetailViewController: UITableViewController {
    var itemCrypto: ItemCrypto?
    let apiController = ApiController.instance
    var history: History?
    var prices: [Double] = []
    var dates: [String] = []
    
    @IBOutlet weak var marketCapLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var priceChart: LineChartView!
    
    override func viewDidLoad() {
        self.navigationItem.title = itemCrypto?.CoinInfo.FullName
        marketCapLabel.text = String(itemCrypto!.RAW.USD.MKTCAP)
        volumeLabel.text = String(itemCrypto!.RAW.USD.VOLUME24HOUR)
        changeLabel.text = String(itemCrypto!.RAW.USD.CHANGE24HOUR)
        apiController.getCryptoHistory(cryptoName: (itemCrypto?.CoinInfo.Name)!, completion: setPriceHistory(_:))
    }
    
    func setPriceHistory(_ priceHistory: History?) {
        guard let historyResponse = priceHistory  else {
            return
        }
        history = historyResponse
        configureCharts()
    }
    
    func configureCharts() {
        
        for price in (history?.Data.Data)!{
            prices.append(price.close)
            let date = Date(timeIntervalSince1970: price.time)
            let dateFormatter = DateFormatter()
            dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm") //Set time style
            dateFormatter.timeZone = .current
            let localDate = dateFormatter.string(from: date)
            dates.append(localDate)
        }
        
        let values = (0...24).map { (i) -> ChartDataEntry in
            return ChartDataEntry(x: Double(i) , y: prices[i])
        }
        
        priceChart.xAxis.valueFormatter = self
        let set1 = LineChartDataSet(entries: values, label: "Prices")
        let data = LineChartData(dataSet: set1)
        self.priceChart.data = data
    }
    
}

extension DetailViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let time = dates
        return time[Int(value)]
    }
}
