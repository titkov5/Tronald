//
//  ApplicationModelsState.swift
//  Tronald
//
//  Created by Ivan Titkov on 09.11.2019.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

protocol ApplicationStateProtocol: RandomMemeQuoteModelProtocol, TagsQuotesListModelProtocol, SearchQuotesListModelProtocol {

}

protocol TagsQuotesListModelProtocol {
    var tagsListModel: Observable <TagsListModel?> { get }
    var quotesListModel: Observable <QuotesListModel?> { get }
    var tag: String { get set }

    func fetchTags()
    func fetchQuotesForTag(_ tag: String)
}

protocol SearchQuotesListModelProtocol {
    var searchQuotesListModel: Observable <SearchQuotesListModel?> { get }
    func searchQuotes(searchQuote: String)
}

protocol RandomMemeQuoteModelProtocol {
    var randomMemeImageData: Observable <Data?> { get }
    var randomQuoteModel: Observable <QuoteModel?> { get }

    func refreshRandomMeme()
    func refreshRandomQuote()
}

class ApplicationState: ApplicationStateProtocol {

    private var networkManager: NetworkManagerProtocol
    private let pageSize = 25

    //tags / quotes  models
    var tagsListModel: Observable<TagsListModel?>
    var quotesListModel: Observable<QuotesListModel?>

    var tag: String = "" {
        didSet {
            self.quotesListModel = Observable(nil)
        }
    }
    
    var randomQuoteModel: Observable<QuoteModel?>
    var randomMemeImageData: Observable<Data?>
    var searchQuotesListModel: Observable<SearchQuotesListModel?>

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        self.randomMemeImageData = Observable(nil)
        self.randomQuoteModel = Observable(nil)
        self.searchQuotesListModel = Observable(nil)
        self.tagsListModel = Observable(nil)
        self.quotesListModel = Observable(nil)
    }

    func refreshRandomMeme() {
        self.networkManager.fetchRandomMeme { imageData in
            self.randomMemeImageData.value = imageData
        }
    }

    func refreshRandomQuote() {
        self.networkManager.fetchRandomQuote { randomQuote in
            if let randomQuote = randomQuote {
                self.randomQuoteModel.value = randomQuote
            }
        }
    }

    func searchQuotes(searchQuote: String) {
        self.networkManager.searchQuotes(searchQuote: searchQuote) { searchListModel in
            self.searchQuotesListModel.value = searchListModel
        }
    }

    func fetchTags() {
        self.networkManager.fetchTags { tagsListModel in
            self.tagsListModel.value = tagsListModel
        }
    }

    func fetchQuotesForTag(_ tag: String) {
        let page = quotesListModel.value?.page ?? 1

        self.networkManager.fetchQuotes(page: page, size: pageSize, tag: tag) { quotesListModel in
            if let newQuotes = quotesListModel?.quotes, newQuotes.count > 0 {
                if self.quotesListModel.value != nil {
                    let quoteModel = self.quotesListModel.value!
                    quoteModel.appendPage(newQuotes)
                    self.quotesListModel.value = quoteModel
                } else {
                    self.quotesListModel.value = quotesListModel
                }
            }
        }
    }
}
