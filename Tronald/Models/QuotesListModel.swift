//
//  Quotes.swift
//  OhTronald
//
//  Created by Ivan Titkov on 13.10.2019.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

class QuoteModel: Decodable {
    var appeared_at: String
    var created_at: String
    var quote_id: String
    var tags: [String]
    var value: String
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
    }
}

