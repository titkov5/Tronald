//
//  NetworkManager.swift
//  OhTronald
//
//  Created by Ivan Titkov on 14.10.2019.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

let baseUrl = "https://api.tronalddump.io/"
let jsonHeaders = ["accept": "application/hal+json"]
let imageHeaders = ["accept": "image/jpeg"]

let kPage = "page"
let kSize = "size"
let kQuery = "query"

struct Endpoints {
    static let tag = "/tag"
    static let quotesByTag = "/tag/"
    static let search = "/search/quote"
    static let randomQuote = "/random/quote"
    static let randomMeme = "/random/meme"
}

protocol TagsAndRelatedQuotesProtocol {
    func fetchTags(completionHandler: @escaping (_ tagsList: TagsListModel?) -> Void)
    func fetchQuotes(page: Int, size:Int, tag: String, completionHandler: @escaping(_ quotes: QuotesListModel?) -> Void)
}

protocol RandomMemeQuoteProvider {
    func fetchRandomMeme(completionHandler: @escaping(_ randomMemeData: Data?) -> Void)
    func fetchRandomQuote(completionHandler: @escaping(_ randomQuote: QuoteModel?) -> Void)
}

protocol SearchQuotesProvider {
    func searchQuotes(searchQuote: String, completionHandler: @escaping(_ quotes: SearchQuotesListModel?) -> Void)
}

protocol NetworkManagerProtocol: RandomMemeQuoteProvider, SearchQuotesProvider, TagsAndRelatedQuotesProtocol {
    
}

class NetworkManager: NetworkManagerProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchTags(completionHandler: @escaping (_ tagsList: TagsListModel?) -> Void) {
        let tagRequest = ApiRequest.init(httpMethod: .GET, path: Endpoints.tag ,
                                         parameters: [:], headers: jsonHeaders)
        
        networkService.fetchEntities(apiRequest: tagRequest, type: TagsListModel.self) { (listModel, error) in
            completionHandler(listModel)
        }
    }
    
    func fetchQuotes(page: Int, size:Int, tag: String, completionHandler: @escaping(_ quotes: QuotesListModel?) -> Void ) {
        
        let pageAsString = String(page)
        let sizeAsString = String(size)
        let parameters:[String: String] = [kPage: pageAsString, kSize: sizeAsString]
        
        let quoteRequest = ApiRequest.init(httpMethod: .GET, path: Endpoints.quotesByTag + tag, parameters: parameters, headers: jsonHeaders)
        
        networkService.fetchEntities(apiRequest: quoteRequest, type: QuotesListModel.self) { (listModel, error) in
            completionHandler(listModel)
        }
    }
    
    func searchQuotes(searchQuote: String, completionHandler: @escaping(_ quotes: SearchQuotesListModel?) -> Void) {
        
        let parameters = [kQuery: searchQuote]
        let searchRequest = ApiRequest.init(httpMethod: .GET, path: Endpoints.search, parameters: parameters, headers: jsonHeaders)
        
        networkService.fetchEntities(apiRequest: searchRequest, type: SearchQuotesListModel.self) { (listModel, error) in
            if let error = error {
                self.handleError(error: error)
            }
            completionHandler(listModel)
        }
    }
    
    func fetchRandomQuote(completionHandler: @escaping(_ randomQuote: QuoteModel?) -> Void) {
        let randomQuoteRequest = ApiRequest.init(httpMethod: .GET, path: Endpoints.randomQuote, headers: jsonHeaders)
        
        networkService.fetchEntities(apiRequest: randomQuoteRequest, type: QuoteModel.self) { (randomQuote, error) in
            if let error = error {
                self.handleError(error: error)
            }
            
            completionHandler(randomQuote)
        }
    }
    
    func fetchRandomMeme(completionHandler: @escaping(_ randomMemeData: Data?) -> Void) {
        let randomMemeRequest = ApiRequest.init(httpMethod: .GET, path: Endpoints.randomMeme, headers: imageHeaders)
        
        networkService.performRequest(apiRequest: randomMemeRequest) { result in
            switch result {
            case .failure(let error):
                self.handleError(error: error)
                completionHandler(nil)
                
            case .success(let data):
                completionHandler(data)
            }
        }
        
    }
    
    func handleError(error : Error) {
        //handle error on top level
        print("internal error:", error.localizedDescription)
    }
}
