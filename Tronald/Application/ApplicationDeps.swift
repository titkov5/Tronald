//
//  ApplicationDeps.swift
//  Tronald
//
//  Created by Ivan Titkov on 08.11.2019.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation


class ApplicationDeps: RandomMemeQuoteViewModelDeps {
    
    var dataProvider: RandomMemeProvider {
        return self.networkManager
    }
    
    lazy var networkManager : NetworkManager = {
        print("CREATE " + #function)
        return NetworkManager()
    }()
    
    

}
