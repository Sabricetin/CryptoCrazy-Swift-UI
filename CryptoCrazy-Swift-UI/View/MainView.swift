//
//  ContentView.swift
//  CryptoCrazy-Swift-UI
//
//  Created by Sabri Çetin on 3.09.2024.
//

import SwiftUI

struct MainView: View {
    
  
    
    @ObservedObject var cryptoListViewModel : CryptoListViewModel
    
    init () {
        self.cryptoListViewModel = CryptoListViewModel()
    }
    var body: some View {
        
       
        NavigationView {
            
            List(cryptoListViewModel.cryptoList /*id:\.id*/) { crypto in
                   
                VStack (alignment: .leading) {
                
                    
                    
                    Text(crypto.symbol)
                        .font(.system(size: 30))
                        .foregroundColor(Color(hex: "#A3208F"))
                        .bold()
                    Text("Price Change: \(crypto.priceChange)")
                        .foregroundColor(Color(hex: "#6A005B"))
                        .bold()
                    Text("Avg Price: \(crypto.weightedAvgPrice)")
                        .font(.system(size: 20))
                        .foregroundColor(Color(hex: "#172D7D"))
                        .bold()
                    Text("Volume: \(crypto.volume)")
                        .font(.system(size: 15))
                        .foregroundColor(Color(hex: "#081B64"))
                        .bold()
                    
                    
                        
                }
            }
            .navigationTitle(Text("Crypto Crazy"))
            }
        .onAppear {
            cryptoListViewModel.downloadCryptos()
        }
    }
    
    
    
}
#Preview {
    MainView()
}
