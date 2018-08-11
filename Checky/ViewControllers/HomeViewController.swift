//
//  ViewController.swift
//  Checky
//
//  Created by Robert Ogiba on 12.07.2018.
//  Copyright © 2018 Robert Ogiba. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
    
    @IBOutlet weak var currencyTableView: UITableView!
    
    var loadedDates: [String] = []
    var dailyRates: [DailyRate] = []
    var fetchingMore = false
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let _vc = segue.destination as? RateDetailsViewController,
            let _selectedRate = sender as? Currency {
            _vc.dailyRate = _selectedRate
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: Setup methods
extension HomeViewController {
    func setupTableView() {
        currencyTableView.register(UINib.init(nibName: "CurrencyTableViewCell", bundle: nil), forCellReuseIdentifier: "test")
        // Do any additional setup after loading the view, typically from a nib.
        
        currencyTableView.rowHeight = UITableViewAutomaticDimension
        currencyTableView.estimatedRowHeight = UITableViewAutomaticDimension
    }
}

//MARK: TableView DataSource & Delegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
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
            
            if let _currencyCode = currency.code,
                let _currencySymbol = currency.symbol {
                _currencyCell.labelView.text = "\(_currencyCode) (\(_currencySymbol))"
            }
            _currencyCell.valueView.text = "\(currency.midValue)"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Clicked item at \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedRate = dailyRates[indexPath.section].rates[indexPath.row]
        performSegue(withIdentifier: "rateDetailsSegue", sender: selectedRate)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        
        if offsetY > contentHeight - scrollView.frame.height * 4 {
            if !fetchingMore {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                if let _lastDate = loadedDates.last {
                    let date = dateFormatter.date(from: _lastDate)
                    let newDate = date?.addingTimeInterval(-1*60*24*60)
                    
                    loadData(for: newDate)
                }
            }
            
        }
    }
}

//MARK: Private methods
extension HomeViewController {
    fileprivate func loadData() {
        RatesApi.getLatest(for: .a, completion: { dailyRate in
            guard let _dailyRate = dailyRate else{
                return
            }
            
            if let _date = _dailyRate.effectiveDate {
                self.loadedDates.append(_date)
            }
            
            self.dailyRates.append(_dailyRate)
            
            DispatchQueue.main.async {
                self.currencyTableView.reloadData()
            }
        })
    }
    
    fileprivate func loadData(for date: Date?) {
        guard let _date = date else {
            return
        }
        
        self.fetchingMore = true
        RatesApi.getHistoricalRates(for: .a, and: _date, completion: { [weak self](dailyRate) in
            self?.fetchingMore = false
            
            guard let _dailyRate = dailyRate else{
                return
            }
            
            if let _date = _dailyRate.effectiveDate {
                self?.loadedDates.append(_date)
            }
            
            self?.dailyRates.append(_dailyRate)
            
            DispatchQueue.main.async {
                self?.currencyTableView.reloadData()
            }
            }, errorCompletion: { [weak self]error in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                let newValue = dateFormatter.string(from: _date)
                
                self?.fetchingMore = false
                self?.loadedDates.append(newValue)
        })
    }
    
    fileprivate func isLoadingCell(for indexPath: IndexPath) -> Bool {
        guard dailyRates.count > 0 else {
            return false
        }
        
        return indexPath.row >= currencyTableView.numberOfRows(inSection: indexPath.section)
    }
}

