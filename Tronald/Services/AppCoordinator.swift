//
//  AppCoordinator.swift
//  Tronald
//
//  Created by Ivan Titkov on 08.11.2019.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

protocol Coordinator {
    var rootTabBarController: UITabBarController { get }
}

class AppCoordinator: Coordinator {

    let rootTabBarController = UITabBarController()
    private let appDeps: ApplicationDeps = ApplicationDeps()

    func start() {
        configureRoot()
    }

    private func configureRoot() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let randomViewController = storyboard.instantiateViewController(withIdentifier: "RandomMemeQuoteViewController") as! RandomMemeQuoteViewController

        let randomViewModel = RandomMemeQuoteViewModel(appState: appDeps.appState)
        randomViewController.bind(to: randomViewModel )

        let randomNavigationController = UINavigationController(rootViewController: randomViewController)
        randomNavigationController.title = "Random"
        randomNavigationController.tabBarItem.image = UIImage.init(named: "gift-7")
        randomNavigationController.navigationBar.topItem?.title = "Random Meme & Quote"

        
        let searchViewModel = SearchQuoteViewModel(appState: appDeps.appState)
        let searchViewController = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        searchViewController.bind(to: searchViewModel)

        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        searchNavigationController.title = "Search"
        searchNavigationController.tabBarItem.image = UIImage.init(named: "search-7")
        searchNavigationController.navigationBar.topItem?.title = "Search"

        let tagViewController = storyboard.instantiateViewController(withIdentifier: "TagsListViewController") as! TagsListViewController
        let tagListViewModel = TagsListViewModel(appState: appDeps.appState)
        tagViewController.bind(to: tagListViewModel)

        let tagsNavigationController = UINavigationController(rootViewController: tagViewController)
        tagsNavigationController.title = "Tags"
        tagsNavigationController.tabBarItem.image = UIImage.init(named: "tag-7")
        tagsNavigationController.navigationBar.topItem?.title = "Tags"

        rootTabBarController.setViewControllers([tagsNavigationController, searchNavigationController, randomNavigationController ], animated: false)

    }
}
