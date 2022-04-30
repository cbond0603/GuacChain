//
//  CurrencyRate.swift
//  GuacChain
//
//  Created by Chris Bond on 4/30/22.
//

import Foundation

class CurrencyRate {
    
    private struct Result: Codable{
        var bpi: BPI
    }
    private struct BPI: Codable {
        var USD: USDStruct
        var GBP: GBPStruct
        var EUR: EURStruct
    }
    private struct USDStruct: Codable {
        var rate_float: Double
    }
    
    private struct GBPStruct: Codable {
        var rate_float: Double
    }
    private struct EURStruct: Codable {
        var rate_float: Double
    }
    
    
    var dollarPerBTC = 0.0
    var poundPerBTC = 0.0
    var euroPerBTC = 0.0
    
    func getData(completed: @escaping () -> ()) {
        let urlString = "https://api.coindesk.com/v1/bpi/currentprice.json"
        print("🕸🕸 We are accessing the url \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("🤬 ERROR: Couldn't create a URL from \(urlString)")
            completed()
            return
        }
        
        //Create Session
        let session = URLSession.shared
        
        //get data with .datatask method
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("🤬 ERROR: \(error.localizedDescription)")
            }
            //deal with data
            do {
                let result = try JSONDecoder().decode(Result.self, from: data!)
                print("*** USD result \(result.bpi.USD.rate_float)")
                print("*** GBP result \(result.bpi.GBP.rate_float)")
                print("*** EUR result \(result.bpi.EUR.rate_float)")
                self.dollarPerBTC = result.bpi.USD.rate_float
                self.euroPerBTC = result.bpi.EUR.rate_float
                self.poundPerBTC = result.bpi.GBP.rate_float

                
            } catch {
                print("🤬 JSON ERROR: \(error.localizedDescription)")
            }
            completed()
        }
        task.resume()
    }
}
