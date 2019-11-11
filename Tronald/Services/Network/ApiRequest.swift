//
//  ApiRequest.swift
//  OhTronald
//
//  Created by Ivan Titkov on 14.10.2019.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

public enum HTTPMethod {
    case GET
    case POST
    case PUT
    case DELETE
}

struct ApiConfig {
    static let host = "api.tronalddump.io"
    static let scheme = "https"
}

public protocol ApiRequestProtocol {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: [String: String]? { get }
    var url: URL? { get }
}

public struct ApiRequest: ApiRequestProtocol {

    public let path: String
    public let httpMethod: HTTPMethod
    public let parameters: [String: String]?
    public let headers: [String: String]?

    public var url: URL? {
        var components = URLComponents()
        components.scheme = ApiConfig.scheme
        components.host = ApiConfig.host
        components.path = path
        components.queryItems = []
        if let parameters = parameters, parameters.count > 0 {
            var queryItems: [URLQueryItem] = []
            for (key, value) in parameters {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
            components.queryItems = queryItems
        }

        return components.url
    }

    init(httpMethod: HTTPMethod, path: String, parameters: [String: String]? = nil, headers: [String: String]?) {
        self.httpMethod = httpMethod
        self.path = path
        self.parameters = parameters
        self.headers = headers
    }
}
