//
//  CommonViewController.swift
//  Tronald
//
//  Created by Ivan Titkov on 08.11.2019.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class CommonViewModel {

}

protocol Bindable {
    func bind(to model: CommonViewModel?)
}

class BindableViewController<ModelType: CommonViewModel>: UIViewController, Bindable {

    var viewModel: ModelType? {

        return _model as? ModelType
    }

    var _model: CommonViewModel?

    func bind(to model: CommonViewModel?) {

        _model = model

        if viewModel != nil {
            modelBinded(viewModel!)
        }
    }

    func modelBinded(_ model: ModelType) { }
}
