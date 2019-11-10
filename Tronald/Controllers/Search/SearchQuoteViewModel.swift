//
//  SearchQuoteViewModel.swift
//  Tronald
//
//  Created by Ivan Titkov on 10.11.2019.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

class SearchQuoteViewModel: CommonViewModel {
    private var appState: SearchQuotesListModelProtocol
    var quotes: Observable<[String]> = Observable([])
    
    init(appState: SearchQuotesListModelProtocol) {
        self.appState = appState
        super.init()

        self.appState.searchQuotesListModel.addObserver(owner: self, callback:{ listModel in
            if let quotesModels = listModel?.quotes, quotesModels.count > 0 {
                var result: [String] = []
                
                for quoteModel in quotesModels {
                    result.append(quoteModel.value)
                }
                self.quotes.value = result
            } else {
                self.quotes.value = []
            }
        })
    }
    
    func searchQuote(searchQuote: String) {
        self.appState.searchQuotes(searchQuote: searchQuote)
    }
}

