//
//  ApiRequest.swift
//  Check24
//
//  Created by Anton Kharchevskyi on 4/25/19.
//  Copyright © 2019 Anton Kharchevskyi. All rights reserved.
//

import Foundation

protocol ApiRequest {
    var path: ApiEndpoint { get }
}

struct ProductsRequest: ApiRequest {
    let path: ApiEndpoint = .productsOverview
}
