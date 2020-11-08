//
//  ConverterManager.swift
//  CurrencyConv
//
//  Created by Łukasz Rajczewski on 08/11/2020.
//

import Foundation

struct ConverterManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "9BDE425D-CDFA-4EAA-B678-F409E670092E"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getRate(_ leftCurrency: String, _ rightCurrency: String) {
        
        print("Left: \(leftCurrency)")
        print("Right: \(rightCurrency)")
    }
    
     //   let urlString = "\(baseURL)\(currencyName)?apikey=\(apiKey)"
}
