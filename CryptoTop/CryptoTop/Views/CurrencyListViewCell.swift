//
//  CurrencyListViewCell.swift
//  CryptoTop
//
//  Created by Islam on 4/22/20.
//  Copyright © 2020 Islam. All rights reserved.
//

import UIKit
import Kingfisher
import Foundation

class CurrencyListViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setDataToLabels(item: ItemCrypto) {
        nameLabel.text = item.CoinInfo.FullName
        let price = (item.RAW.USD.PRICE * 1000).rounded() / 1000
        let change = (item.RAW.USD.CHANGEPCT24HOUR * 1000).rounded() / 1000
        priceLabel.text = String(price)
        changeLabel.text = String(change) + "%"
        if change > 0{
            changeLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        }else{
            changeLabel.textColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
        }
        
        let stringUrl = "https://cryptocompare.com" + item.CoinInfo.ImageUrl

        guard let imageUrl = URL(string: stringUrl) else { return }
        self.imageCell.kf.setImage(with: imageUrl)

    }
}
