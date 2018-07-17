//
//  ViewController.swift
//  Checky
//
//  Created by Robert Ogiba on 12.07.2018.
//  Copyright © 2018 Robert Ogiba. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var currencyTableView: UITableView!
    
    var sectionTitles: [String] = []
    var dailyRates: [DailyRate] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyTableView.register(UINib.init(nibName: "CurrencyTableViewCell", bundle: nil), forCellReuseIdentifier: "test")
        // Do any additional setup after loading the view, typically from a nib.
        
        currencyTableView.rowHeight = UITableViewAutomaticDimension
        currencyTableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        RatesApi.getLatest(for: .a, completion: { dailyRate in
            guard let _dailyRate = dailyRate else{
                return
            }
            
            self.dailyRates.append(_dailyRate)
            DispatchQueue.main.async {
                self.currencyTableView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dailyRates.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyRates[section].rates.count;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dailyRates[section].effectiveDate
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "test", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let _currencyCell = cell as? CurrencyTableViewCell {
            let currency = dailyRates[indexPath.section].rates[indexPath.row]
            
            _currencyCell.labelView.text = currency.code
            _currencyCell.valueView.text = "\(currency.midValue)"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Clicked item at \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

