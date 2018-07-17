//
//  DailyRate.swift
//  Checky
//
//  Created by Robert Ogiba on 17.07.2018.
//  Copyright © 2018 Robert Ogiba. All rights reserved.
//

import Foundation
import ObjectMapper

class DailyRate: Mappable {
    var table: String?
    var tableNo: String?
    var effectiveDate: String?
    var rates: [Currency] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.table <- map["table"]
        self.tableNo <- map["no"]
        self.effectiveDate <- map["effectiveDate"]
        self.rates <- map["rates"]
    }
}
