//
//  CurrencyApi.swift
//  Checky
//
//  Created by Robert Ogiba on 16.07.2018.
//  Copyright © 2018 Robert Ogiba. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class CurrencyApi {
    static let latestEndpoint = "http://api.nbp.pl/api/exchangerates/tables"
    
    static func getLatest(for table: Table, completion: ((_ dailyRate: DailyRate?) -> ())?,
                          errorCompletion: ((_ error: String) -> ())? = nil) {
        Alamofire.request("\(CurrencyApi.latestEndpoint)/\(table.rawValue)")
            .responseArray { (response: DataResponse<[DailyRate]>) in
            if let _data = response.value, _data.count > 0 {
                completion?(_data.first)
            } else if let _error = response.error {
                errorCompletion?(_error.localizedDescription)
            }
        }
    }
}
