//
//  RandomMemeQuoteViewModel.swift
//  Tronald
//
//  Created by Ivan Titkov on 08.11.2019.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

protocol RandomMemeQuoteViewModelDeps {
    var dataProvider: RandomMemeProvider { get }
}


struct QuoteViewModel: Identifiable, Hashable {
    var id: Int
    var value: String
}

class RandomMemeQuoteViewModel: CommonViewModel {
    private var deps: RandomMemeQuoteViewModelDeps
    var quote: Observable <QuoteViewModel>
    var image: Observable <UIImage?>
    
    private var imageData: Data? {
        didSet {
            if let imageData = imageData {
                self.image.value = UIImage(data: imageData)
            }
        }
    }
    
    init(deps: RandomMemeQuoteViewModelDeps) {
        self.deps = deps
        self.quote = Observable(QuoteViewModel(id: 0, value: "text"))
        self.image = Observable(nil)
    }
    
    func loadRandomMeme() {
        self.deps.dataProvider.fetchRandomMeme { data in
            self.imageData = data
        }
    }
    
    func loadRandomQuote() {
        self.deps.dataProvider.fetchRandomQuote { randomQuote in
            if let randomQuote = randomQuote {
                self.quote.value =  QuoteViewModel(id: 0, value: randomQuote.value)
            }
        }
    }
}
