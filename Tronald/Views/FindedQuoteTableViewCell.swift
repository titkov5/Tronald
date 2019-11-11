//
//  FindedQuoteTableViewCell.swift
//  Tronald
//
//  Created by Ivan Titkov on 11.11.2019.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class FindedQuoteTableViewCell: UITableViewCell {

    @IBOutlet private var quoteTextView: UITextView!

    func setup(foundQuote: FoundQuoteViewModel) {
        quoteTextView.attributedText = foundQuote.attributedQuote
    }

}
