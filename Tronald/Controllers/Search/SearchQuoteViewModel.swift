//
//  SearchQuoteViewModel.swift
//  Tronald
//
//  Created by Ivan Titkov on 10.11.2019.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

struct FindedQuoteViewModel {
    var attributedQuote: NSAttributedString
}

class SearchQuoteViewModel: CommonViewModel {
    private var appState: SearchQuotesListModelProtocol
    private var searchQuote: String = ""
    
    var quotes: Observable<[FindedQuoteViewModel]> = Observable([])
    
    init(appState: SearchQuotesListModelProtocol) {
        self.appState = appState
        super.init()

        self.appState.searchQuotesListModel.addObserver(owner: self, callback:{ listModel in
            if let quotesModels = listModel?.quotes, quotesModels.count > 0 {
                
                self.quotes.value = quotesModels.map({ quoteModel in
                    let font = UIFont.systemFont(ofSize: 15)
                    let attributes: [NSAttributedString.Key: Any] = [
                        .font: font,
                        .foregroundColor: UIColor.black,
                    ]
                    
                    let attributedQuote = NSMutableAttributedString(string: quoteModel.value, attributes: attributes)
                    
                    let Selecteattributes: [NSAttributedString.Key: Any] = [.backgroundColor: UIColor.lightGray]
                    
                    let ranges = quoteModel.value.nsRanges(of: self.searchQuote, options: [.caseInsensitive])
                    ranges.forEach {range in
                       attributedQuote.addAttributes(Selecteattributes, range: range)
                    }
                    
                    return FindedQuoteViewModel(attributedQuote: attributedQuote)
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

