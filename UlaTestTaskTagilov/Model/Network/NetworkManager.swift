//
//  NetworkManager.swift
//  UlaTestTaskTagilov
//
//  Created by Владимир on 28.03.2024.
//

import Foundation

final class NetworkManager {
    static func fetchServices(completion: @escaping (NetworkResponce) -> ()) {
        let urlString = "https://publicstorage.hb.bizmrg.com/sirius/result.json"
        guard let url = URL(string: urlString) else {
            completion(.init(error: .badURL))
            return
        }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.init(error: .noInternetConnectivity))
                return
            }
            guard let data = data else {
                completion(.init(error: .dataEmpty))
                return
            }
            completion(.init(data: data))
        }.resume()
    }
    static func fetchData(urlString: String, completion: @escaping (NetworkResponce) -> ()) {
        guard let url = URL(string: urlString) else {
            completion(.init(error: .badURL))
            return
        }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.init(error: .noInternetConnectivity))
                return
            }
            guard let data = data else {
                completion(.init(error: .dataEmpty))
                return
            }
            completion(.init(data: data))
        }.resume()
    }
}
