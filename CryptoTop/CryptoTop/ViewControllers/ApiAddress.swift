//
//  ApiAddress.swift
//  eNotes
//
//  Created by Yan Saraev on 7/23/17.
//  Copyright © 2017 4taps. All rights reserved.
//

import Foundation
import Alamofire

struct ApiAddress {
    var scheme = "https"
    var domain = "min-api.cryptocompare.com"
    var apiKey = "39bfa1458f8bbd10e9187c300ec089d34ec62cba0d5814994fbab30ac624923a"
    var endpoint: String = ""
    var param: String = ""
    
    init(endpoint: String) {
        self.endpoint = endpoint
        self.param = getStringFrom(parameter: nil)
    }
    
    init(endpoint: String, param: [String: Any]?) {
        self.endpoint = endpoint
        self.param = getStringFrom(parameter: param as! [String: String]?)
    }
    
    func getURLString() -> String {
        return "\(scheme)://\(domain)/\(endpoint)\(param)"
    }
    
    func getURL() -> URL? {
        return URL(string: getURLString())
    }
    
    func getStringFrom(parameter: [String:String]?) -> String {
        var parameterString = "&api_key=\(apiKey)"
        
        if parameter == nil {
            return parameterString
        }
        for (key, value) in parameter! {
            if key.contains("readyStringParameter") {
                parameterString += value
            } else {
                parameterString += "&\(key)=\(value)"
            }
        }
        return parameterString
    }
}
