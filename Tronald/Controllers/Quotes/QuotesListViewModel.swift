//
//  QuotesListViewModel.swift
//  Tronald
//
//  Created by Ivan Titkov on 10.11.2019.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

class QuotesListViewModel: CommonViewModel {
    
    var quotes: Observable<[String]> = Observable([])
    var modelIsFull: Bool = false
    var appState: TagsQuotesListModelProtocol
    var tag: String = "" {
        didSet {
            self.fetchQuotesForTag(tag)
        }
    }
    
    init(appState: TagsQuotesListModelProtocol) {
        self.appState = appState
        super.init()
        
        self.appState.quotesListModel.addObserver(owner: self, callImmediately: true) { quotesModels in
            var result: [String] = []
            self.modelIsFull = quotesModels?.isFull ?? false
            
            if let quotesModels = quotesModels?.quotes {
                for quoteModel in quotesModels {
                    result.append(quoteModel.value)
                }
                self.quotes.value = result
                
            } else {
                self.quotes.value = []
            }
        }
        
        
    }
    
    func fetchQuotesForTag(_ tag: String) {
        appState.fetchQuotesForTag(tag)
    }
    
    func fetchNextPage() {
        fetchQuotesForTag(tag)
    }
}
