//
//  History.swift
//  CryptoTop
//
//  Created by Islam on 4/24/20.
//  Copyright © 2020 Islam. All rights reserved.
//

import Foundation

class History: Codable {
    let Response, Message: String
    let Data: Histories
}

class Histories: Codable {
    let TimeFrom: Double
    let TimeTo: Double
    let Data: [PriceHistory]
}
