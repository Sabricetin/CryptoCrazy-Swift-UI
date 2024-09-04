//
//  Webservice.swift
//  CryptoCrazy-Swift-UI
//
//  Created by Sabri Çetin on 4.09.2024.
//

import Foundation

class Webservice {
    func downloadCurrencies(url : URL , completion : @escaping (Result<[CryptoCurrency]?,DownloaderError>)-> Void) {
        URLSession.shared.dataTask(with: url) { data , response , error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.badUrl))
            }
            guard let data = data , error == nil else {
                return completion(.failure(.noData))
            }
            guard let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data) else {
                return completion(.failure(.dataParseError))
            }
            completion(.success(currencies))
        } .resume()
    }
}
enum DownloaderError : Error {
    case badUrl
    case noData
    case dataParseError
}
