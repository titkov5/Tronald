//
//  RandomMemeQuoteViewModel.swift
//  Tronald
//
//  Created by Ivan Titkov on 08.11.2019.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class RandomMemeQuoteViewModel: CommonViewModel {
    
    private var dataFetcher: RandomMemeQuoteFetcher
    private var appState: RandomMemeQuoteModel
    
    var randomMemeImage: Observable <UIImage?>
    var randomQuoteText: Observable <String?>
    
    init(appState:RandomMemeQuoteModel, dataFetcher: RandomMemeQuoteFetcher) {
         
        self.appState = appState
        self.dataFetcher = dataFetcher
        
        self.randomMemeImage = Observable(nil)
        self.randomQuoteText = Observable(nil)
        
        super.init()
        
        self.appState.randomMemeImageData.addObserver(owner: self) { data in
            if let imageData = data {
                self.randomMemeImage.value = UIImage(data: imageData)
            }
        }
        
        self.appState.randomQuoteModel.addObserver(owner: self) { quoteModel in
            self.randomQuoteText.value = quoteModel?.value
        }
    }
    
    func loadRandomMeme() {
        self.dataFetcher.refreshRandomMeme()
    }
    
    func loadRandomQuote() {
        self.dataFetcher.refreshRandomQuote()
    }
}
