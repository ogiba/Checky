//
//  ApiHelper.swift
//  Checky
//
//  Created by Robert Ogiba on 17.07.2018.
//  Copyright © 2018 Robert Ogiba. All rights reserved.
//

import Foundation

class ApiHelper {
    static let baseUrl = "http://api.nbp.pl/api"
    
    static var exchangeRateEnpoint = "\(baseUrl)/exchangerates"
    
    static func latestEndpoint(for table:TableType) -> String {
        return exchangeRateEnpoint + "/tables/\(table.rawValue)"
    }
    
    static func dateEndpoint(for table: TableType, in date: Date) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let rawDate = dateFormatter.string(from: date)
        
        return exchangeRateEnpoint + "/tables/\(table.rawValue)/\(rawDate)"
    }
}
