//
//  ContentView.swift
//  CryptoCurrencySUI
//
//  Created by Nazlı Bekeç on 19.04.2023.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var cryptoListViewModel : CryptoListViewModel
    
    init() {
        self.cryptoListViewModel = CryptoListViewModel()
    }
    
    var body: some View {
   
        NavigationView {
            List(cryptoListViewModel.cryptoList, id:\.id) { crypto in
                VStack{
                    Text(crypto.curreny)
                        .font(.title3)
                        .foregroundColor(.blue)
                        .frame(maxWidth:.infinity,alignment: .leading)
                    Text(crypto.price)
                        .foregroundColor(.green)
                        .frame(maxWidth:.infinity,alignment: .leading)
                }
            }.navigationTitle(Text("Crypto Currency"))
        }.onAppear {
            // Bu görünüm oluşturulduğunda veriler indirilir
            cryptoListViewModel.downloadCryptos(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")! )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
