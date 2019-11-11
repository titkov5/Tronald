//
//  Quotes.swift
//  OhTronald
//
//  Created by Ivan Titkov on 13.10.2019.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

struct Source: Decodable {
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
    }
}

class QuoteModel: Decodable {
    var appearedAt: String
    var createdAt: String
    var quoteId: String
    var tags: [String]
    var value: String
    var urls: [String]
    
    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
        case source
        case appeared_at
        case created_at
        case quote_id
        case tags
        case value
        case url
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        appearedAt = try container.decode(String.self, forKey: .appeared_at)
        createdAt = try container.decode(String.self, forKey: .created_at)
        quoteId = try container.decode(String.self, forKey: .quote_id)
        tags = try container.decode([String].self, forKey: .tags)
        value = try container.decode(String.self, forKey: .value)

        let embeddedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .embedded)
        let source = try embeddedContainer.decode([Source].self, forKey: .source)
        urls = source.map { $0.url }
    }
}

class QuotesListModel: Decodable {
    var count: Int = 0
    var total: Int = 0
    var quotes: [QuoteModel]
    var page: Int = 1
    var isFull: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
        case tags
        case count
        case total
        case quotes
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        total = try container.decode(Int.self, forKey: .total)
        
        let nestedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .embedded)
        quotes = try nestedContainer.decode([QuoteModel].self, forKey: .tags)
        page += 1
        isFull = total == count
    }
    
    func appendPage(_ quotes: [QuoteModel]) {
        self.quotes.append(contentsOf: quotes)
        self.count  = self.quotes.count
        self.isFull = self.count == self.total
        self.page += 1
    }
}
