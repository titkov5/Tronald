//
//  SearchViewController.swift
//  Tronald
//
//  Created by Ivan Titkov on 10.11.2019.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class SearchViewController: BindableViewController<SearchQuoteViewModel>, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var searchTextField: UITextField!
    
    private var searchedQuotes : [FindedQuoteViewModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView.init()
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.keyboardDismissMode = .onDrag
        self.searchTextField.delegate = self
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func searchTextDidChanged(_ sender: UITextField) {
        if let textForSearch = sender.text, textForSearch.count > 2 {
            viewModel?.searchQuote(searchQuote: textForSearch)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedQuotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let quoteCell = tableView.dequeueReusableCell(withIdentifier: "FindedQuoteTableViewCell") as! FindedQuoteTableViewCell
        quoteCell.setup(findedQuote:self.searchedQuotes[indexPath.row])
        return quoteCell
    }
    
    override func modelBinded(_ model: SearchQuoteViewModel) {
        super.modelBinded(model)
        loadViewIfNeeded()
        
        self.viewModel?.quotes.addObserver(owner:self, callback: { quotes in            self.searchedQuotes = quotes
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
