//
//  NetworkError.swift
//  UlaTestTaskTagilov
//
//  Created by Владимир on 28.03.2024.
//

enum NetworkError: Error, Decodable {
    case badURL
    case noInternetConnectivity
    case dataEmpty
    
    var description: String {
        switch self {
        case .badURL, .dataEmpty:
            return "Сервис временно недоступен"
        case .noInternetConnectivity:
            return "Отсутствует интернет соединение"
        }
    }
}
