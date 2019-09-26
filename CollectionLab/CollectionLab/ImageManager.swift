//
//  ImageManager.swift
//  CollectionLab
//
//  Created by EricM on 9/26/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import Foundation
import UIKit

struct ImageManager {
    private init() {}
    
    static let shared = ImageManager()
    
    static func getImage(stringURL: String, completionHandler: @escaping (Result<UIImage, AppError>) -> () ) {
        guard let url = URL(string: stringURL) else {
            completionHandler(.failure(.badURL))
            return
        }
        let request = URLRequest.init(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completionHandler(.failure(.badURL))
            } else if let data = data {
                let image = UIImage.init(data: data)
                completionHandler(.success(image!))
            }
            }.resume()
    }
}
