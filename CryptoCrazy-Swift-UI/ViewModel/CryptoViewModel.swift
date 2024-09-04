//
//  CryptoViewModel.swift
//  CryptoCrazy-Swift-UI
//
//  Created by Sabri Çetin on 4.09.2024.
//


import Foundation

// Model yapısı (Crypto verilerini temsil ediyor)
struct CryptoModel: Identifiable, Codable {
    let id = UUID()  // Her bir model için benzersiz bir ID
    let symbol: String
    let priceChange: String
    let weightedAvgPrice: String
    let volume: String
}

class CryptoListViewModel: ObservableObject {
    
    @Published var cryptoList = [CryptoModel]()  // View'a bağlı olan veri
    
    // API'den veri indiren fonksiyon
    func downloadCryptos() {
        let headers = [
            "x-rapidapi-key": "2b377c5311msh5167a0b402e0210p127dabjsn69aae958db97",
            "x-rapidapi-host": "binance43.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://binance43.p.rapidapi.com/ticker/24hr")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print("API Hatası: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Veri bulunamadı!")
                return
            }
            
            // JSON'u decode ediyoruz
            do {
                let decoder = JSONDecoder()
                let cryptos = try decoder.decode([CryptoModel].self, from: data)  // JSON verisini [CryptoModel] olarak decode ediyoruz
                
                DispatchQueue.main.async {
                    // cryptoList'i güncelliyoruz
                    self.cryptoList = cryptos
                }
            } catch {
                print("JSON çözümleme hatası: \(error)")
            }
        }

        dataTask.resume()
    }
}



/*
import Foundation

  class CryptoListViewModel : ObservableObject {
    
 @Published var cryptoList = [CryptoViewModel]()
            let webservice = Webservice()
    
    func downloadCryptos (url : URL) {
        webservice.downloadCurrencies(url: url) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let cryptos):
                if let cryptos = cryptos {
                    DispatchQueue.main.async {
                        self.cryptoList = cryptos.map(CryptoViewModel.init)

                    }
                }
            }
        }
    }
}

struct CryptoViewModel {
    let crypto : CryptoCurrency
    
    var id : UUID? {
        crypto.id
    }
    var symbol : String {
        crypto.symbol
    }
    var weightedAvgPrice : String {
        crypto.weightedAvgPrice
    }
    var volume : String {
        crypto.volume
    }
    var priceChange : String {
        crypto.priceChange
    }
}
*/
