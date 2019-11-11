//
//  QuotesListViewModel.swift
//  Tronald
//
//  Created by Ivan Titkov on 10.11.2019.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

struct QuoteViewModel {
    let value: String
    let url: URL?
    let created: String
}

class QuotesListViewModel: CommonViewModel {
    
    var quotes: Observable<[QuoteViewModel]> = Observable([])
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

            self.modelIsFull = quotesModels?.isFull ?? false
            
            if let quotesModels = quotesModels?.quotes {
                self.quotes.value = quotesModels.map {
                    //TODO viewModel creater
                   

                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss"
                    //dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    let date = dateFormatter.date(from: $0.appearedAt)
                
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                    let appearedAtString = dateFormatter.string(from: date ?? Date())

                    
                    let url = URL(string: $0.urls.first ?? "")
                    let posted = "posted:" + appearedAtString
                    return QuoteViewModel(value: $0.value, url: url, created: posted)
                }
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
