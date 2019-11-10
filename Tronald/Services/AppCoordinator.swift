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

        let vm = RandomMemeQuoteViewModel(appState: appDeps.appState , dataFetcher: appDeps.appState)
        
        rndVC.bind(to: vm )
       
        let navigationController = UINavigationController(rootViewController: rndVC)
             navigationController.title = "RNDM"
             //navigationController.tabBarItem.image = UIImage.init(named: "map-icon-1")
        
       let vc = UIViewController.init()
        vc.view.backgroundColor = .black
        
        let navigationController2 = UINavigationController(rootViewController: vc)
        navigationController2.title = "black"
        
        
        rootTabBarController.setViewControllers([navigationController, navigationController2], animated: false)
        
    }
    
}
