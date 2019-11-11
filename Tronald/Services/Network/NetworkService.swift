//
//  NetworkService.swift
//  OhTronald
//
//  Created by Ivan Titkov on 14.10.2019.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

public typealias NetworkCompletionHandler = (Result<Data, NetworkServiceError>) -> Void

public protocol NetworkServiceProtocol {

    func performRequest(apiRequest: ApiRequestProtocol, completion: @escaping NetworkCompletionHandler)

    func fetchEntities<T>(apiRequest: ApiRequestProtocol, type: T.Type, completion: @escaping (T?, NetworkServiceError?) -> Void) where T: Decodable

    func decodeResponse<T: Decodable>(entityType: T.Type, data: Data) -> T?
}

public class NetworkService: NetworkServiceProtocol {

    init() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        self.defaultSession = URLSession(configuration: config)
    }

    private let defaultSession: URLSession

    public func performRequest(apiRequest: ApiRequestProtocol, completion: @escaping NetworkCompletionHandler) {

        if let url = apiRequest.url {
            var sessionTask: URLSessionTask?
            switch apiRequest.httpMethod {
            case .GET:
                sessionTask = defaultSession.dataTask(with: url) { ( data, response, error) in
                    DispatchQueue.main.async {
                        if let response = response as? HTTPURLResponse {
                            if response.statusCode == 200 {
                                if let data = data {
                                    completion(.success(data))
                                } else {
                                    completion(.failure(.emptyData))
                                }
                            } else {
                                if let error = NetworkServiceError(responseStatus: response.statusCode) {
                                    completion(.failure(error))
                                } else {
                                    completion(.failure(.networkError("network error with code:" + String(response.statusCode))))
                                }
                            }
                        }
                    }
                }

                sessionTask?.resume()

            default:
                DispatchQueue.main.async {
                    completion(.failure(.unsupportedHttpMethod))
                }
                return
            }
        } else {
            DispatchQueue.main.async {
                completion(.failure(.badUrl))
            }

            return
        }
    }

    public func fetchEntities<T: Decodable>(apiRequest: ApiRequestProtocol, type: T.Type, completion: @escaping (T?, NetworkServiceError?) -> Void) {
        performRequest(apiRequest: apiRequest) { result in
            switch result {
            case .failure(let error):
                completion(nil, error)

            case .success(let data):
                let entities = self.decodeResponse(entityType: type, data: data)
                completion(entities, nil)
            }
        }
    }

    public func decodeResponse<T: Decodable>(entityType: T.Type, data: Data) -> T? {
        do {
            let response = try JSONDecoder().decode(entityType, from: data)
            return response
        } catch let error {
            self.handleError(error: error)
        }

        return nil
    }

    func handleError(error: Error) {
        //handle error on low level
        print(error.localizedDescription)
    }
}
