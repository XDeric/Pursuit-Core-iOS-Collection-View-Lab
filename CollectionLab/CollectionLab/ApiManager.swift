//
//  ApiManager.swift
//  CollectionLab
//
//  Created by EricM on 9/26/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import Foundation

struct StuffAPTClient {
    static let manager = StuffAPTClient()
    
    func getPlants(completionHandler: @escaping (Result<[Plant], AppError>) -> () ) {
        NetworkManager.manager.performDataTask(url: airTablePlantURL, httpMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                return
            case .success(let data):
                do {
                    let plants = try Plant.getPlants(from: data)
                    completionHandler(.success(plants))
                }
                catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
}
