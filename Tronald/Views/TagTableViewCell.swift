//
//  TagTableViewCell.swift
//  Tronald
//
//  Created by Ivan Titkov on 10.11.2019.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class TagTableViewCell: UITableViewCell {
    
    @IBOutlet private var taglabel: UILabel!
    
    func setup(text: String) {
        self.taglabel.text = text
    }
}


