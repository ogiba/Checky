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
}
