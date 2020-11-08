//
//  ConverterManager.swift
//  CurrencyConv
//
//  Created by Łukasz Rajczewski on 08/11/2020.
//

import Foundation

protocol ConverterManagerDelegate {
    func didUpdateRate(leftC: String, rightC: String, rateC: String)
    func didFailWithError(_ error: Error)
}

struct ConverterManager {
    
    var delegate: ConverterManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate"
    let apiKey = "9BDE425D-CDFA-4EAA-B678-F409E670092E"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getRate(_ leftCurrency: String, _ rightCurrency: String) {
        let urlString = "\(baseURL)/\(leftCurrency)/\(rightCurrency)?apikey=\(apiKey)"
        print(urlString)
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error!)
                    return
                } else {
                    if let safeData = data {
                        if let currencyRate = parseJSON(safeData) {
                            let currencyString = String(format: "%.4f", currencyRate)
                            delegate?.didUpdateRate(leftC: leftCurrency, rightC: rightCurrency, rateC: currencyString)
                        }
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ safeData: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CurrencyModel.self, from: safeData)
            let rate = decodedData.rate
            return rate
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
        }

}
