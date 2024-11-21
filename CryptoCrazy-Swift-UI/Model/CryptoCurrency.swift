//
//  CryptoCurrency.swift
//  CryptoCrazy-Swift-UI
//
//  Created by Sabri Çetin on 3.09.2024.
//

import Foundation

struct CryptoCurrency : Decodable , Identifiable {
    
    let id = UUID()
    let symbol : String
    let weightedAvgPrice : String
    let volume : String
    let priceChange : String
    
    
    private enum CodingKeys : String , CodingKey {
        
        case symbol = "symbol"
        case weightedAvgPrice = "weightedAvgPrice"
        case volume = "volume"
        case priceChange = "priceChange"
    }
}
