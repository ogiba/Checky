//
//  Currency.swift
//  Checky
//
//  Created by Robert Ogiba on 17.07.2018.
//  Copyright © 2018 Robert Ogiba. All rights reserved.
//

import Foundation
import ObjectMapper

class Currency: Mappable {
    var currency:String?
    var code: String?
    var symbol: String?
    var midValue: Double = 0.0
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.currency <- map["currency"]
        self.code <- map["code"]
        self.midValue <- map["mid"]
        self.symbol = code?.getCurrencySymbol()
    }
}
