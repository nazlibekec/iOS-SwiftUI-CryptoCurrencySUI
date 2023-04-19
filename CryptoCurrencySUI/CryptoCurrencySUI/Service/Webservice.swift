//
//  Webservice.swift
//  CryptoCurrencySUI
//
//  Created by Nazlı Bekeç on 19.04.2023.
//

import Foundation
import Alamofire

class CryptoDataService {
    
    func downloadCurrencies (url : URL, completion: @escaping (Result<[CryptoCurrency]?, DownloaderError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.badURL))
            }
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            guard let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data) else {
                    return completion(.failure(.dataParseError))
            }
                                  
            completion(.success(currencies))
            }.resume()
    }
    

    
    enum DownloaderError : Error {
        case badURL
        case noData
        case dataParseError
    }
}
