//
//  TagsListViewModel.swift
//  Tronald
//
//  Created by Ivan Titkov on 10.11.2019.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

class TagsListViewModel: CommonViewModel {
    
    var appState: TagsQuotesListModelProtocol
    
    var tags: Observable<[String]> = Observable([])
    
    init(appState: TagsQuotesListModelProtocol) {
        self.appState = appState
        super.init()
        self.appState.tagsListModel.addObserver(owner: self, callImmediately: false) { tagList in
            self.tags.value = tagList?.tags ?? []
        }
    }
    
    func fetchTags() {
        appState.fetchTags()
    }
}
