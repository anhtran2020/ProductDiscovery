//
//  SearchCoordinator.swift
//  ProductDiscovery
//
//  Created by David Tran on 3/14/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import UIKit
import Domain
import RxSwift
import RxCocoa
import Swinject

class SearchCoordinator: BaseCoordinator {
    
    var presenter: BaseNavigationController?
    var navigationController: BaseNavigationController!
    
    init(presenter: BaseNavigationController?) {
        self.presenter = presenter
    }

    override func start() {
        guard let searchVC = Assembler.resolve(SearchViewController.self) else {
            return
        }
        
        navigationController = BaseNavigationController(rootViewController: searchVC)
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.providesPresentationContextTransitionStyle = true
        navigationController.modalPresentationStyle = .overFullScreen
        navigationController.modalTransitionStyle = .crossDissolve
        self.presenter?.present(navigationController, animated: true, completion: nil)
        
        searchVC.backAction.bind(to: backActionBinder).disposed(by: disposeBag)
        searchVC.showDetailAction.bind(to: showProductDetailBinder).disposed(by: disposeBag)
        
        handleStore(coordinator: self)
    }
}

extension SearchCoordinator {
    
    var backActionBinder: Binder<Void> {
        return Binder(self) { (target, _) in
            target.navigationController?.dismiss(animated: true, completion: nil)
            target.isCompleted?()
        }
    }
    
    private var showProductDetailBinder: Binder<Product> {
        return Binder(self) { (target, product) in
            target.showProductDetailScreen(product)
        }
    }
}

extension SearchCoordinator {
    
    private func showProductDetailScreen(_ product: Product) {
        let coordinator = ProductDetailCoordinator(navigationController: navigationController, product: product)
        coordinator.start()
        
        handleStore(coordinator: coordinator)
    }
}
