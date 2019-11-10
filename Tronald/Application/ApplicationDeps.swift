//
//  ApplicationDeps.swift
//  Tronald
//
//  Created by Ivan Titkov on 08.11.2019.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation


class ApplicationDeps {
    
    lazy var networkService : NetworkServiceProtocol = {
        print("CREATE " + #function)
        return NetworkService()
    }()
    
    lazy var networkManager : NetworkManager = {
        print("CREATE " + #function)
        return NetworkManager(networkService: self.networkService)
    }()
    
    lazy var appState: ApplicationStateProtocol = {
        print("CREATE " + #function)
        return ApplicationState(networkManager: self.networkManager)
    }()
    
}
