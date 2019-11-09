//
//  RandomMemeQuoteViewController.swift
//  Tronald
//
//  Created by Ivan Titkov on 08.11.2019.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class RandomMemeQuoteViewController: BindableViewController<RandomMemeQuoteViewModel> {
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var label: UILabel!
    
    override func viewDidLoad() {
        self.viewModel?.loadRandomQuote()
    }
    
    @IBAction func refreshRndMeme() {
        self.viewModel?.loadRandomMeme()
    }
    
    @IBAction func refreshQuote() {
         self.viewModel?.loadRandomQuote()
     }
    
     override func modelBinded(_ model: RandomMemeQuoteViewModel) {
        super.modelBinded(model)
        loadViewIfNeeded()
        model.quote.addObserver(owner: self, callback: { model in
            self.label.text = model.value
        })
        
        model.image.addObserver(owner: self) { image in
            self.imageView.image = image
        }
        
    }
}