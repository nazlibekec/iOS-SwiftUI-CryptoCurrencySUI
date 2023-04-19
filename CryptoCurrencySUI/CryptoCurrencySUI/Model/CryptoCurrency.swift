//
//  CryptoCurrency.swift
//  CryptoCurrencySUI
//
//  Created by Nazlı Bekeç on 19.04.2023.
//

import Foundation

struct CyrptoCurrency : Hashable, Decodable, Identifiable {
    
    let id = UUID()
    let currency : String
    let price : String
    
    //Servisten id gelmeyeceği için aşağıdaki işlem yapılır.
    //CodingKey : oluşturacağımız enumlarla hangi değişken için hangi isimde geleceğini belirteceğimiz yapı.
    //CodingKeys kullanıldığında Hashable da kullanılması tavsiye edilir.
    
    private enum CodingKeys : String, CodingKey {
        case currency = "currency"
        case price = "price"
    }
}
