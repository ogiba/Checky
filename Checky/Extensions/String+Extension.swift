//
//  String+Extension.swift
//  Checky
//
//  Created by Robert Ogiba on 17.07.2018.
//  Copyright © 2018 Robert Ogiba. All rights reserved.
//

import Foundation

extension String {
    func getCurrencySymbol() -> String? {
        let locale = NSLocale(localeIdentifier: self)
        return locale.displayName(forKey: .currencySymbol, value: self)
    }
    
    var currencyName: String? {
        get {
            let locale = NSLocale(localeIdentifier: self)
            return locale.localizedString(forCurrencyCode: self)
        }
    }
}
