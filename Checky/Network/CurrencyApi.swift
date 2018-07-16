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
    static let api = "http://data.fixer.io/api/latest?access_key=[accessKey]"
    
    static func getLatest(completion: ((_ currencies: Currencies?) -> ())?,
                          errorCompletion: ((_ error: String) -> ())? = nil) {
        Alamofire.request(CurrencyApi.api)
            .responseObject{ (response: DataResponse<Currencies>) in
            if let _data = response.value {
                completion?(_data)
            } else if let _error = response.error {
                errorCompletion?(_error.localizedDescription)
            }
        }
    }
}
