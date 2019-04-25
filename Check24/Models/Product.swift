//
//  Product.swift
//  Check24
//
//  Created by Anton Kharchevskyi on 4/25/19.
//  Copyright © 2019 Anton Kharchevskyi. All rights reserved.
//

import Foundation

struct ProductsResponse: Codable {
    let header: HeaderModel
    let filters: [String]
    let products: [Product]
}

struct HeaderModel: Codable {
    let headerTitle: String
    let headerDescription: String
}

struct Product: Codable {
    let name: String
    let type: String
    let id: Int
    let color: String
    let imageURL: String
    let colorCode: String
    let available: Bool
    let releaseDate: Int
    let description: String
    let longDescription: String
    let rating: Double
    let price: Price
}

struct Price: Codable {
    let value: Double
    let currency: String
}
