//
//  APIError.swift
//  Check24
//
//  Created by Anton Kharchevskyi on 4/25/19.
//  Copyright © 2019 Anton Kharchevskyi. All rights reserved.
//

import Foundation

enum APIError: Error {
    // data mapping error, pretty self-explanatory
    case dataMapping
    // any error occurred during the request sending
    case request(Error)
    case malformedBaseURL
}
