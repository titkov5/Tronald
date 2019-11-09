//
//  AppDelegate.swift
//  Tronald
//
//  Created by Ivan Titkov on 08.11.2019.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var coordinator = AppCoordinator()
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = coordinator.rootTabBarController
        self.window?.makeKeyAndVisible()

        coordinator.start()
        return true
    }

}

