//
//  NetworkResponce.swift
//  UlaTestTaskTagilov
//
//  Created by Владимир on 28.03.2024.
//

import Foundation

struct NetworkResponce: Decodable {
    let error: NetworkError?
    let data: Data?
    
    init(error: NetworkError? = nil, data: Data? = nil) {
        self.error = error
        self.data = data
    }
}
