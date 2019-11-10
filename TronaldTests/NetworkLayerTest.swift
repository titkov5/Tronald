//
//  NetworkLayerTest.swift
//  OhTronaldTests
//
//  Created by Ivan Titkov on 14.10.2019.
//  Copyright © 2019 none. All rights reserved.
//

import XCTest

@testable import OhTronald

class NetworkLayerTest: XCTestCase {
    var networkService: NetworkServiceProtocol?
    
    var tagEntitiesRequest: ApiRequest {
        ApiRequest(httpMethod:  .GET, path: "/tag", headers: headers )
    }
    
    var quotesEntitiesRequest: ApiRequest {
        ApiRequest(httpMethod: .GET, path: "/search/quote", parameters: ["query" : "obama", "page":"1", "size":"3"], headers: headers)
    }
    
    let headers: [String : String] = ["accept": "application/hal+json"]
    
    override func setUp() {
        networkService = NetworkService()
    }


    func testPerformSimpleRequest() {
        let expectation = XCTestExpectation(description: "SimpleRequestTest")

        networkService?.performRequest(apiRequest: tagEntitiesRequest, completion: { (result) in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            default:
                XCTFail()
            }
            
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 3)
    }

    func testCheckBadUrlError() {
        let request = ApiRequest(httpMethod: .GET, path: "tag", headers: headers)
        
        let expectation = XCTestExpectation(description: "SimpleRequestTest")
        
        networkService?.performRequest(apiRequest: request, completion: { (result) in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertTrue(error == .badUrl)
            default:
                XCTFail()
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 3)
    }
    
    func testFetchEntities() {
        let tagExpectation = expectation(description: "FetchTagEntities")
        
        networkService?.fetchEntities(apiRequest: tagEntitiesRequest, type: TagsListModel.self, completion: { (entities, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(entities)
            tagExpectation.fulfill()
        })
        
        let quoteExpectation = expectation(description: "FetchQuoteEntities")
        
        networkService?.fetchEntities(apiRequest: quotesEntitiesRequest, type: QuotesListModel.self, completion: { (entities, error) in
            XCTAssertNil(error)
            XCTAssertTrue(entities?.count == 3)
            quoteExpectation.fulfill()
        })
        
        wait(for: [tagExpectation, quoteExpectation], timeout: 3)
    }
    
    func testParsingTagEntities() {
        let tagsUrl = Bundle(for: NetworkLayerTest.self).url(forResource: "tags", withExtension: "json")
        XCTAssertNotNil(tagsUrl)
        let data = try? Data(contentsOf: tagsUrl ?? URL(fileURLWithPath: ""))
        XCTAssertNotNil(data)
        let entities = networkService?.decodeResponse(entityType: TagsListModel.self, data: data!)
        XCTAssertTrue(entities?.count == 54)
        XCTAssertEqual(entities?.tags?.first , "Hillary Clinton" )
    }

}
