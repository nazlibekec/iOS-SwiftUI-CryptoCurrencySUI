//
//  CryptoViewModel.swift
//  CryptoCurrencySUI
//
//  Created by Nazlı Bekeç on 19.04.2023.
//

import Foundation
import Combine

class CryptoListViewModel : ObservableObject {
    
    //gözlemlenebilir bi obje olabilmesi için published deriz. Liste değiştiğinde view kendini yenileyecek.
    @Published var cryptoList = [CryptoViewModel]()
    
    let webservice = CryptoDataService()
    func downloadCryptos(url : URL ) {
        webservice.downloadCurrencies(url: url) { result in
            switch result {
            case.failure(let error):
                print(error)
                
            case.success(let cryptos):
                if let cryptos = cryptos {
                    //cryptolist kullanıcı arayüzünü etkileyeceği için;
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
    var curreny : String {
        crypto.currency
    }
    var price : String {
        crypto.price
    }
}
