//
//  Webservice.swift
//  CryptoCurrencySUI
//
//  Created by Nazlı Bekeç on 19.04.2023.
//

import Foundation
import Alamofire

class CryptoDataService {

    func downloadCurrencies(url: URL, completion: @escaping (Result<[CryptoCurrency]?, DownloaderError>) -> Void) {
        AF.request(url).validate().responseDecodable(of: [CryptoCurrency].self) { response in
            switch response.result {
            case .success(let currencies):
                // Başarılıysa, tamamlama işlevine [CryptoCurrency] dizisini ve .success durumunu geçiyoruz
                completion(.success(currencies))
            case .failure(let error):
                switch error {
                case .invalidURL:
                    // URL geçersizse, tamamlama işlevine .badURL durumuna geç
                    completion(.failure(.badURL))
                case .responseValidationFailed(let reason):
                    switch reason {
                    case .dataFileNil, .dataFileReadFailed:
                        // Yanıtta veri yoksa veya veri okunamıyorsa, tamamlama işlevine .noData durumuna geç
                        completion(.failure(.noData))
                    default:
                        // Ayrıştırma hatası veya diğer hatalar durumunda, tamamlama işlevine .dataParseError durumuna geç
                        completion(.failure(.dataParseError))
                    }
                default:
                    // Diğer hatalar durumunda, tamamlama işlevine .noData durumuna geç
                    completion(.failure(.noData))
                }
            }
        }
    }
    
    enum DownloaderError: Error {
        case badURL
        case noData
        case dataParseError
    }
}

/*
 
URLSession ile yazılan servis
 
 import Foundation
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
 */

