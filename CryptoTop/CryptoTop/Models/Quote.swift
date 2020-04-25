//
//  Quote.swift
//  CryptoTop
//
//  Created by Islam on 4/22/20.
//  Copyright © 2020 Islam. All rights reserved.
//

import UIKit

class Quote: Codable {
    let USD: QuoteCurrency
}

class QuoteCurrency: Codable {
    let PRICE: Double
    let MKTCAP: Double
    let CHANGEPCT24HOUR: Double
    let CHANGE24HOUR: Double
    let VOLUME24HOUR: Double
}
