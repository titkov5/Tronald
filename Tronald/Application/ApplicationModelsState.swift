//
//  ApplicationModelsState.swift
//  Tronald
//
//  Created by Ivan Titkov on 09.11.2019.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

protocol ApplicationStateProtocol: RandomMemeQuoteModel, RandomMemeQuoteFetcher {
   
}

protocol RandomMemeQuoteModel {
    var randomMemeImageData: Observable <Data?> { get }
    var randomQuoteModel: Observable <QuoteModel?> { get }
}

protocol RandomMemeQuoteFetcher {
    func refreshRandomMeme()
    func refreshRandomQuote()
}

class ApplicationState: ApplicationStateProtocol {
    private var networkManager: NetworkManagerProtocol
    
    var randomQuoteModel: Observable<QuoteModel?>
    var randomMemeImageData: Observable<Data?>
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        randomMemeImageData = Observable(nil)
        randomQuoteModel =  Observable(nil)
    }
    
    func refreshRandomMeme() {
        self.networkManager.fetchRandomMeme { imageData in
            self.randomMemeImageData.value = imageData
        }
    }
    
    func refreshRandomQuote() {
        self.networkManager.fetchRandomQuote { randomQuote in
                 if let randomQuote = randomQuote {
                     self.randomQuoteModel.value =  QuoteModel(value: randomQuote.value)
                 }
             }
    }
    
}
