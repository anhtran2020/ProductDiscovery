//
//  ViewModelAssembly.swift
//  ProductDiscovery
//
//  Created by Anh Tran on 3/12/20.
//  Copyright © 2020 David Tran. All rights reserved.
//

import Swinject
import Domain
import Network

struct ViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(ProductViewModel.self) { resolver in
            let service = resolver.resolve(ProductServiceType.self)
            return ProductViewModel(service: service!)
        }
        
        container.register(SearchViewModel.self) { resolver in
            let service = resolver.resolve(ProductServiceType.self)
            return SearchViewModel(service: service!)
        }
        
        container.register(ProductDetailViewModel.self) { (resolver: Resolver, product: Product) in
            let service = resolver.resolve(ProductServiceType.self)
            return ProductDetailViewModel(service: service!, product: product)
        }
    }
}
