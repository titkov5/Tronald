//
//  SearchQuoteViewModel.swift
//  Tronald
//
//  Created by Ivan Titkov on 10.11.2019.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

struct FoundQuoteViewModel {
    var attributedQuote: NSAttributedString
}

class SearchQuoteViewModel: CommonViewModel {
    private var appState: SearchQuotesListModelProtocol
    private var searchQuote: String = ""
    
    var quotes: Observable<[FoundQuoteViewModel]> = Observable([])
    
    init(appState: SearchQuotesListModelProtocol) {
        self.appState = appState
        super.init()

        self.appState.searchQuotesListModel.addObserver(owner: self, callback:{ listModel in
            if let quotesModels = listModel?.quotes, quotesModels.count > 0 {
                
                self.quotes.value = quotesModels.map({ quoteModel in
                    self.findQuoteViewModelBuilder(quoteModel: quoteModel)
                })
            } else {
                self.quotes.value = []
            }
        })
    }
    
    func searchQuote(searchQuote: String) {
        self.searchQuote = searchQuote
        self.appState.searchQuotes(searchQuote: searchQuote)
    }
    
}

extension SearchQuoteViewModel {
    private var font : UIFont {
        return UIFont.systemFont(ofSize: 15)
    }
    
    private var attributes : [NSAttributedString.Key: Any] {
        return  [
            .font: font,
            .foregroundColor: UIColor.black,
        ]
    }
    
    private var highlightedTextAttr: [NSAttributedString.Key: Any] {
        [.backgroundColor: UIColor.lightGray]
    }
    
    func findQuoteViewModelBuilder(quoteModel: QuoteModel) -> FoundQuoteViewModel {
        
        let attributedQuote = NSMutableAttributedString(string: quoteModel.value, attributes: attributes)

        let ranges = quoteModel.value.nsRanges(of: self.searchQuote, options: [.caseInsensitive])
        ranges.forEach {range in
            attributedQuote.addAttributes(highlightedTextAttr, range: range)
        }
        
        return FoundQuoteViewModel(attributedQuote: attributedQuote)
        
    }
}

