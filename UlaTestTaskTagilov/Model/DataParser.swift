//
//  DataParser.swift
//  UlaTestTaskTagilov
//
//  Created by Владимир on 28.03.2024.
//

import Foundation

final class ServiceResponseParser {
    static func parseWeatherData(_ data: Data) -> ServicesResponce? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(ServicesResponce.self, from: data)
            return result
        } catch {
            return nil
        }
    }
}
