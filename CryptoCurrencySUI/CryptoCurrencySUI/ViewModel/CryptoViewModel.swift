//
//  CryptoViewModel.swift
//  CryptoCurrencySUI
//
//  Created by Nazlı Bekeç on 19.04.2023.
//

import Foundation
import Combine

class CryptoListViewModel : ObservableObject {
    
    // @Published değişkeni, liste öğelerinde değişiklik olduğunda otomatik olarak görünümün yeniden yüklenmesini tetikler.
    @Published var cryptoList = [CryptoViewModel]()
    
    let webservice = CryptoDataService()
    
    // URL parametresi alır ve bu URL'den kripto para birimleri verilerini indirir.
    func downloadCryptos(url : URL ) {
        webservice.downloadCurrencies(url: url) { result in
            switch result {
            case.failure(let error):
                print(error)
                
            case.success(let cryptos):
                if let cryptos = cryptos {
                    // Veriler kullanıcı arayüzünü etkileyeceği için main thread'de yapılır
                    DispatchQueue.main.async {
                        // Yeni CryptoViewModel öğeleri, mevcut cryptos öğeleri üzerinden oluşturulur ve cryptoList'e eklenir.
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
