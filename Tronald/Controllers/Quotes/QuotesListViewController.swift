//
//  QuotesListViewController.swift
//  Tronald
//
//  Created by Ivan Titkov on 10.11.2019.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class QuotesListViewController: BindableViewController <QuotesListViewModel>, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet var quotesList: UITableView!
    
    private var quotes:[String] = [] {
        didSet {
            self.quotesList.reloadData()
            self.quotesList.tableFooterView = tableViewFooter()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.quotesList.estimatedRowHeight = 44.0
        self.quotesList.rowHeight = UITableView.automaticDimension
    }
    
    override func modelBinded(_ model: QuotesListViewModel) {
        super.modelBinded(model)
        loadViewIfNeeded()
        self.quotesList.tableFooterView = UIView.init()
        self.viewModel?.quotes.addObserver(owner:self, callback: { quotes in
            self.quotes = quotes
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let quoteCell = tableView.dequeueReusableCell(withIdentifier: "QuoteTableViewCell") as! QuoteTableViewCell
        quoteCell.setup(quoteText:self.quotes[indexPath.row])
        return quoteCell
    }
    
    func tableViewFooter() -> UIView? {
        if self.viewModel?.modelIsFull ?? false {
            return UIView.init()
        } else {
            return nextButtonView()
        }
    }
    
    func nextButtonView() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 176))
        let uploadNextPageButton = UIButton.init(type: .custom)
        uploadNextPageButton.frame = CGRect(x: 0, y: 0, width: 88, height: 44)

        uploadNextPageButton.setTitle("More...", for: .normal)

        uploadNextPageButton.setTitleColor(.white, for: .normal)
 
        uploadNextPageButton.addTarget(self, action: #selector(uploadNextPage), for: .touchUpInside)
        uploadNextPageButton.backgroundColor = UIColor.init(red: 83/255, green: 173/255, blue: 240/255, alpha: 1)
        uploadNextPageButton.layer.cornerRadius = 8
        uploadNextPageButton.clipsToBounds = true
        view.addSubview(uploadNextPageButton)
        uploadNextPageButton.center = view.center
        return view
    }
    
    @objc
    func uploadNextPage() {
        self.viewModel?.fetchNextPage()
    }
}
