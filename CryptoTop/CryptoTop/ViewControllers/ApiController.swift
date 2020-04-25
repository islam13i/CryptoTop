//
//  ApiController.swift
//  CryptoTop
//
//  Created by Islam on 4/22/20.
//  Copyright © 2020 Islam. All rights reserved.
//

import UIKit
import Alamofire

struct EndPoints {
    let cryptoCurrencies = "data/top/mktcapfull?limit=10&tsym=USD"
    let cryptoHistory = "data/v2/histohour?tsym=USD&limit=24"
    static let instance = EndPoints()
}

class ApiController {
    
    static let instance = ApiController()
    let endPoints = EndPoints.instance
    
    func getcryptoCurrencies( completion: @escaping ([ItemCrypto])-> ()) {
        let urlString = ApiAddress(endpoint: endPoints.cryptoCurrencies).getURLString()
        guard let url = URL(string: urlString) else{ return }
        
        AF.request(url).validate().responseDecodable(of: Listings.self) { (response) in
            guard let items = response.value else { return print(response.error ?? "") }
            DispatchQueue.main.async {
                completion(items.Data)
            }
        }
    }
    
    func getCryptoHistory(cryptoName: String, completion: @escaping (History)-> ()) {
        let urlString = ApiAddress(endpoint: endPoints.cryptoHistory + "&fsym=" + cryptoName).getURLString()
        guard let url = URL(string: urlString) else{ return }
        
        AF.request(url).validate().responseDecodable(of: History.self) { (response) in
            guard let item = response.value else { return print(response.error ?? "") }
            DispatchQueue.main.async {
                completion(item)
            }
        }
    }
}
