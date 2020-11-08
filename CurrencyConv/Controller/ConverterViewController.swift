//
//  ViewController.swift
//  CurrencyConv
//
//  Created by Łukasz Rajczewski on 08/11/2020.
//

import UIKit

class ConverterViewController: UIViewController {

    @IBOutlet weak var leftCurrencyLabel: UILabel!
    @IBOutlet weak var rightCurrencyLabel: UILabel!
    @IBOutlet weak var currencyRateLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var converterManager = ConverterManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        converterManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
       
    }
}

extension ConverterViewController: ConverterManagerDelegate {
    func didUpdateRate(leftC: String, rightC: String, rateC: String) {
        DispatchQueue.main.async {
            self.leftCurrencyLabel.text = leftC
            self.rightCurrencyLabel.text = rightC
            self.currencyRateLabel.text = rateC
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
    
    
}

extension ConverterViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return converterManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return converterManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        let leftCurrencyRow = currencyPicker.selectedRow(inComponent: 0)
        let rightCurrencyRow = currencyPicker.selectedRow(inComponent: 1)
        
        let leftCurrencyName = converterManager.currencyArray[leftCurrencyRow]
        let rightCurrencyName = converterManager.currencyArray[rightCurrencyRow]
        
        converterManager.getRate(leftCurrencyName, rightCurrencyName)
        
    }
    
}

