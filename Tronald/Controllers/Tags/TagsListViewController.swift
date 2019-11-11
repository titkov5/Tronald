//
//  TagsListViewController.swift
//  Tronald
//
//  Created by Ivan Titkov on 10.11.2019.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class TagsListViewController: BindableViewController <TagsListViewModel>, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tagsList: UITableView!

    private var tags: [String] = [] {
        didSet {
            self.tagsList.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tagsList.tableFooterView = UIView.init()
        self.viewModel?.fetchTags()
    }

    override func modelBinded(_ model: TagsListViewModel) {
        super.modelBinded(model)
        loadViewIfNeeded()
        self.viewModel?.tags.addObserver(owner: self, callImmediately: true, callback: { tags in
            self.tags = tags
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return tags.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tagCell = tableView.dequeueReusableCell(withIdentifier: "TagTableViewCell") as! TagTableViewCell
        tagCell.setup(text: tags[indexPath.row])

        return tagCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.viewModel?.appState.tag = self.tags[indexPath.row]

        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let quotesViewController = storyboard.instantiateViewController(withIdentifier: "QuotesListViewController") as! QuotesListViewController

        let quotesListModel = QuotesListViewModel(appState: self.viewModel!.appState)
        quotesViewController.bind(to: quotesListModel)
        quotesListModel.tag = self.viewModel?.appState.tag ?? ""

        self.navigationController?.pushViewController(quotesViewController, animated: true)
    }

}
