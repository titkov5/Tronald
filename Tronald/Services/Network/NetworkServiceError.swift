//
//  NetworkServiceError.swift
//  OhTronald
//
//  Created by Ivan Titkov on 14.10.2019.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

public enum NetworkServiceError: Error, Equatable {
    case badUrl
    case unsupportedHttpMethod
    case networkError(String)
    case emptyData
    case badRequest
    case missingCredentials
    case authenticationFailed
    case notFound
    case alreadyExists
    case serviceUnavailable
    case internalServerError
    case internetConnectionProblem
    case notAllowedMethod
    case notAcceptable
    case gone
    case teapot
    case tooManyRequests
    case preconditionFailed
    
    public static func ==(lhs: NetworkServiceError, rhs: NetworkServiceError) -> Bool {
        switch (lhs, rhs) {
        case (.badUrl, .badUrl),
             (.badRequest, .badRequest),
             (.unsupportedHttpMethod, .unsupportedHttpMethod),
             (.networkError, .networkError),
             (.missingCredentials,.missingCredentials),
             (.authenticationFailed, .authenticationFailed),
             (.alreadyExists, .alreadyExists),
             (.internalServerError, .internalServerError),
             (.internetConnectionProblem, .internetConnectionProblem):
            return true
        default:
            return false
        }
    }
    
    init?(responseStatus: Int) {
        switch responseStatus {
        case 400:
            self = .badRequest
        case 401:
            self = .missingCredentials
        case 403:
            self = .authenticationFailed
        case 404:
            self = .notFound
        case 405:
            self = .notAllowedMethod
        case 406:
            self = .notAcceptable
        case 410:
            self = .gone
        case 412:
            self = .preconditionFailed
        case 418:
            self = .teapot
        case 429:
            self = .tooManyRequests
        case 409:
            self = .alreadyExists
        case 503:
            self = .serviceUnavailable
        case 500:
            self = .internalServerError
        case -1001:
            self = .internetConnectionProblem
        case -1003:
            self = .internetConnectionProblem
            
        default:
            return nil
        }
    }
}

