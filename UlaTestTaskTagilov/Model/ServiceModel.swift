//
//  ServiceModel.swift
//  UlaTestTaskTagilov
//
//  Created by Владимир on 27.03.2024.
//

struct ServicesResponce: Codable {
    let body: ResponceBody
}

struct ResponceBody: Codable {
    let services: [ServiceModel]
}

struct ServiceModel: Codable {
    let name: String
    let description: String
    let link: String
    let icon_url: String
}
