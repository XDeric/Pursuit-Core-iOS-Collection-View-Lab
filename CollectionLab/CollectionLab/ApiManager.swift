//
//  ApiManager.swift
//  CollectionLab
//
//  Created by EricM on 9/26/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import Foundation

import UIKit

struct Country: Codable{
    let name: String
    let flag: String
    let capital: String
    let population: Int
    let alpha2Code: String
    //let currencies: [currency]
}

struct currency: Codable {
    let code: String
}

//-------------------------------------------------------------------------------
//struct Exchange: Codable{
//    let rates: signWrapper
//}
//
//struct signWrapper: Codable {
//    let code: [currency]
//}
//---------------------------------------------------------------------------------



struct StuffAPIClient {
    static let manager = StuffAPIClient()
    
    func getCountry(completionHandler: @escaping (Result<[Country], AppError>) -> () ) {
        let urlStr = "https://restcountries.eu/rest/v2"
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(.badURL))
            return
        }
        NetworkManager.manager.performDataTask(url: url, httpMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                return
            case .success(let data):
                do {
                    let countries = try JSONDecoder().decode ([Country].self, from: data)
                    completionHandler(.success(countries))
                }
                catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
}
    
//    struct ExchangeAPIClient {
//        static let manager = StuffAPIClient()
//
//        func getCountry(completionHandler: @escaping (Result<[Exchange], AppError>) -> () ) {
//            let urlStr = "http://data.fixer.io/api/latest?access_key=a17aef5ece92cf36d9c5963f7f4babf1&format=1"
//            guard let url = URL(string: urlStr) else {
//                completionHandler(.failure(.badURL))
//                return
//            }
//            NetworkManager.manager.performDataTask(url: url, httpMethod: .get) { (result) in
//                switch result {
//                case .failure(let error):
//                    return
//                case .success(let data):
//                    do {
//                        let money = try JSONDecoder().decode ([Exchange].self, from: data)
//                        completionHandler(.success(money))
//                    }
//                    catch {
//                        completionHandler(.failure(.couldNotParseJSON(rawError: error)))
//                    }
//                }
//            }
//        }
//    }
