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

        let vm = RandomMemeQuoteViewModel(deps: appDeps)
        rndVC.bind(to: vm )
       
        let vc = UIViewController.init()
        vc.view.backgroundColor = .black
        rootTabBarController.setViewControllers([rndVC, vc], animated: false)
    }
    
}
