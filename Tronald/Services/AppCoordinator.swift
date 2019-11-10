//
//  AppCoordinator.swift
//  Tronald
//
//  Created by Ivan Titkov on 08.11.2019.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

protocol Coordinator {
    var rootTabBarController : UITabBarController { get }
}

class AppCoordinator: Coordinator {
 
    let rootTabBarController = UITabBarController()
    private let appDeps: ApplicationDeps = ApplicationDeps()
    
    func start() {
        configureRoot()
//        window = UIWindow.init(frame: UIScreen.main.bounds)
//        window.rootViewController = rootTabBarController
//        window.makeKeyAndVisible()
    }
    
    private func configureRoot() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let rndVC = storyboard.instantiateViewController(withIdentifier: "RandomMemeQuoteViewController") as! RandomMemeQuoteViewController

        let vm = RandomMemeQuoteViewModel(appState: appDeps.appState)
        rndVC.bind(to: vm )
        
        let rndNC = UINavigationController(rootViewController: rndVC)
        rndNC.title = "RNDM"
             //navigationController.tabBarItem.image = UIImage.init(named: "map-icon-1")
        
        let searchViewModel = SearchQuoteViewModel(appState: appDeps.appState)
        let searchVC = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        searchVC.bind(to: searchViewModel)
        
        let searchNC = UINavigationController(rootViewController: searchVC)
        searchNC.title = "Search"
        
        let tagViewController = storyboard.instantiateViewController(withIdentifier: "TagsListViewController") as! TagsListViewController
        
        let tagList = TagsListViewModel(appState: appDeps.appState)
        tagViewController.bind(to: tagList)
        
        let tagNC = UINavigationController(rootViewController: tagViewController)
        tagNC.title = "Tags"
        
        rootTabBarController.setViewControllers([tagNC, searchNC , rndNC ], animated: false)
        
    }
}
