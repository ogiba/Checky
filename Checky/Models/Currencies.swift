//
//  Currencies.swift
//  Checky
//
//  Created by Robert Ogiba on 16.07.2018.
//  Copyright © 2018 Robert Ogiba. All rights reserved.
//

import Foundation
import ObjectMapper

class Currencies: Mappable {
    var date: String?
    var ratesDict: Dictionary<String, Double>?
    var rates: [OldCurrency] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        date <- map["date"]
        ratesDict <- map["rates"]
        rates = convert(ratesDict: ratesDict)
    }

    func convert(ratesDict: Dictionary<String, Double>?) -> [OldCurrency] {
        guard let _ratesDict = ratesDict else {
            return []
        }
        
        return _ratesDict.map { (key, value) -> OldCurrency in
            return OldCurrency(label: key, value: value)
        }.sorted(by: {$0.label < $1.label})
    }
}
