//
//  Tag.swift
//  OhTronald
//
//  Created by Ivan Titkov on 13.10.2019.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

public class TagsListModel: Decodable {
    public let tags: [String]?
    public let count: Int
    public let total: Int

    enum CodingKeys: String, CodingKey {
        case tags = "_embedded"
        case count = "count"
        case total = "total"
    }

    internal init(tags: [String], count: Int, total: Int) {
        self.tags = tags
        self.total = total
        self.count = count
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        tags = try container.decode([String].self, forKey: .tags)
        total = try container.decode(Int.self, forKey: .total)
        count = try container.decode(Int.self, forKey: .count)
    }
}
