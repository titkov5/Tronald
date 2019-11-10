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
    
    @IBOutlet private var refreshMemeButton: UIButton!
    @IBOutlet private var refreshQuoteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel?.loadRandomQuote()
        self.viewModel?.loadRandomMeme()
        
        self.refreshMemeButton.layer.cornerRadius = 8
        self.refreshMemeButton.clipsToBounds = true
        
        self.refreshQuoteButton.layer.cornerRadius = 8
        self.refreshQuoteButton.clipsToBounds = true
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
        
        model.randomQuoteText.addObserver(owner: self, callback: { randomQuoteText in
            self.label.text = randomQuoteText
        })
        
        model.randomMemeImage.addObserver(owner: self) { image in
            self.imageView.image = image
        }
    }
}
