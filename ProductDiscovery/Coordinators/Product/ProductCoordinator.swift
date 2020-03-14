//
//  ProductCoordinator.swift
//  ProductDiscovery
//
//  Created by Anh Tran on 3/12/20.
//  Copyright © 2020 David Tran. All rights reserved.
//

import UIKit
import Swinject
import RxSwift
import RxCocoa

class ProductCoordinator: BaseCoordinator {
    
    let window: UIWindow
    var navigationController: BaseNavigationController?
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = BaseNavigationController()
    }

    override func start() {
        guard let productVC = Assembler.resolve(ProductViewController.self) else {
            return
        }

        navigationController = BaseNavigationController(rootViewController: productVC)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        productVC.showSearchBar.bind(to: showSearchScreenBinder).disposed(by: disposeBag)
    }
}

extension ProductCoordinator {
    
    private var showSearchScreenBinder: Binder<Void> {
        return Binder(self) { (target, _) in
            target.showSearchScreen()
        }
    }
}

extension ProductCoordinator {
    
    private func showSearchScreen() {
        let searchCoordinator = SearchCoordinator(presenter: navigationController)
        searchCoordinator.start()
        
        handleStore(coordinator: searchCoordinator)
    }
}
