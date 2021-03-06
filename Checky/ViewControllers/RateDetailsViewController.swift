//
//  RateDetailsViewController.swift
//  Checky
//
//  Created by Robert Ogiba on 09.08.2018.
//  Copyright © 2018 Robert Ogiba. All rights reserved.
//

import UIKit

class RateDetailsViewController: UIViewController {
    
    @IBOutlet weak var rateValueLabel: UILabel!
    @IBOutlet weak var currencyNameLabel: UILabel!
    
    weak var dailyRate: Currency?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let _rate = dailyRate {
            self.title = _rate.code
            
            currencyNameLabel.text = _rate.code?.currencyName ?? ""
            rateValueLabel.text = "1 \("PLN".getCurrencySymbol() ?? "PLN") - \(_rate.midValue) \(_rate.symbol!)"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("RateDetailsViewController deinited")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
