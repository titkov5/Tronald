//
//  SearchListModel.swift
//  OhTronald
//
//  Created by Ivan Titkov on 04.11.2019.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

class SearchQuotesListModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
        case quotes
    }
    
    var quotes: [Quote]
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let nestedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .embedded)
        quotes = try nestedContainer.decode([Quote].self, forKey: .quotes)
    }
}
