//
//  StringProtocolExtension.swift
//  Tronald
//
//  Created by Ivan Titkov on 11.11.2019.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

extension StringProtocol {
    
    func nsRange(of string: Self, options: String.CompareOptions = [], range: Range<Index>? = nil, locale: Locale? = nil) -> NSRange? {
        guard let range = self.range(of: string, options: options, range: range ?? startIndex..<endIndex, locale: locale ?? .current) else { return nil }
        return .init(range, in: self)
    }
    
    func nsRanges(of string: Self, options: String.CompareOptions = [], range: Range<Index>? = nil, locale: Locale? = nil) -> [NSRange] {
        var start = range?.lowerBound ?? startIndex
        let end = range?.upperBound ?? endIndex
        var ranges: [NSRange] = []
        while start < end, let range = self.range(of: string, options: options, range: start..<end, locale: locale ?? .current) {
            ranges.append(.init(range, in: self))
            start = range.upperBound
        }
        return ranges
    }
}
