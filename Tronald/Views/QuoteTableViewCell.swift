//
//  QuoteTableViewCell.swift
//  Tronald
//
//  Created by Ivan Titkov on 10.11.2019.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class QuoteTableViewCell: UITableViewCell {
    
    @IBOutlet private var quoteTextView: UITextView!
    @IBOutlet private var avatar: UIImageView!
    @IBOutlet private var dateLabel: UILabel!
    
    func setup(quoteViewModel: QuoteViewModel) {
        quoteTextView.text = quoteViewModel.value //quoteText
        dateLabel.text = quoteViewModel.created
        avatar.layer.cornerRadius = 22
        avatar.clipsToBounds = true
    }

}
