//
//  ViewControllerCoordinator.swift
//  ProductDiscovery
//
//  Created by Anh Tran on 3/12/20.
//  Copyright © 2020 David Tran. All rights reserved.
//

import Swinject
import Domain
import Network

struct ViewControllerAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ProductViewController.self) { resolver in
            let productVC = UIViewController.instantiateViewController(fromStoryboard: .product, ofType: ProductViewController.self)
            productVC.viewModel = resolver.resolve(ProductViewModel.self)
            return productVC
        }
        
        container.register(SearchViewController.self) { resolver in
            let searchVC = UIViewController.instantiateViewController(fromStoryboard: .product, ofType: SearchViewController.self)
            searchVC.viewModel = resolver.resolve(SearchViewModel.self)
            return searchVC
        }
        
        container.register(ProductDetailViewController.self) { (resolver: Resolver, product: Product) in
            let detailVC = UIViewController.instantiateViewController(fromStoryboard: .product, ofType: ProductDetailViewController.self)
            detailVC.viewModel = resolver.resolve(ProductDetailViewModel.self, argument: product)
            return detailVC
        }
    }
}
