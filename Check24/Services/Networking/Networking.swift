//
//  Networking.swift
//  Check24
//
//  Created by Anton Kharchevskyi on 4/25/19.
//  Copyright © 2019 Anton Kharchevskyi. All rights reserved.
//

import Foundation

typealias ProductCompletion = (Result<[Product], APIError>) -> ()

protocol NetworkingApiType {
    func getProducts(_ request: ApiRequest, completion: ProductCompletion?)
    func dispose()
}

final class NetworkingApi: NetworkingApiType {
    static let `default` = NetworkingApi(
        baseURL: URL(string: "https://app.check24.de")!,
        session: .shared,
        decoder: JSONDecoder()
    )

    private let session: URLSession
    private let baseURL: URL
    private let decoder: JSONDecoder
    private let networkinQueue = DispatchQueue(label: "com.check24.networking.queue", qos: .background)
    var dataTask: URLSessionDataTask?

    init(baseURL: URL, session: URLSession, decoder: JSONDecoder) {
        self.baseURL = baseURL
        self.session = session
        self.decoder = decoder
    }

    func getProducts(_ request: ApiRequest, completion: ProductCompletion?) {
        dataTask?.cancel()

        guard var components = URLComponents(string: baseURL.absoluteString) else {
            completion?(Result.failure(APIError.malformedBaseURL))
            return
        }

        components.path = request.path.url

        guard let url = components.url else {
            completion?(Result.failure(APIError.malformedBaseURL))
            return
        }

        dataTask = session.dataTask(with: url) { [weak self] (data, response, error) in
            defer { self?.dataTask = nil }

            guard let self = self else { return }
            if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                do {
                    let products = try self.decoder.decode(ProductsResponse.self, from: data).products
                    completion?(Result.success(products))
                } catch let error {
                    completion?(Result.failure(APIError.request(error)))
                }
            } else if let error = error {
                completion?(Result.failure(APIError.request(error)))
            }
        }
        dataTask?.resume()
    }

    func dispose() {
        dataTask?.cancel()
        dataTask = nil
    }
}

enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)
}


