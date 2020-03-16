//
//  ProductDetailCoordinator.swift
//  ProductDiscovery
//
//  Created by David Tran on 3/15/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import UIKit
import Domain
import RxSwift
import RxCocoa
import Swinject

class ProductDetailCoordinator: BaseCoordinator {
    
    var navigationController: BaseNavigationController?
    var product: Product!
    
    init(navigationController: BaseNavigationController?, product: Product) {
        self.navigationController = navigationController
        self.product = product
    }
    
    override func start() {
        guard let product = product,
            let detailVC = Assembler.resolve(ProductDetailViewController.self, argument: product) else {
            return
        }
        
        navigationController?.pushViewController(detailVC, animated: true)
        
        detailVC.backAction.bind(to: backActionBinder).disposed(by: disposeBag)
        detailVC.showRelativeProductAction.bind(to: showRelativeProductBinder).disposed(by: disposeBag)
        
        handleStore(coordinator: self)
    }
}

extension ProductDetailCoordinator {
    
    var backActionBinder: Binder<Void> {
        return Binder(self) { (target, _) in
            target.navigationController?.popViewController(animated: true)
            target.isCompleted?()
        }
    }
    
    var showRelativeProductBinder: Binder<Product> {
        return Binder(self) { (target, product) in
            target.showProductDetailScreen(product)
        }
    }
}

extension ProductDetailCoordinator {
    
    private func showProductDetailScreen(_ product: Product) {
        let coordinator = ProductDetailCoordinator(navigationController: navigationController, product: product)
        coordinator.start()
        
        handleStore(coordinator: coordinator)
    }
}
