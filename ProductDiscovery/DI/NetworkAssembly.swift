//
//  NetworkAssembly.swift
//  ProductDiscovery
//
//  Created by Anh Tran on 3/12/20.
//  Copyright © 2020 David Tran. All rights reserved.
//

import Swinject
import Domain
import NetworkModule

struct NetworkAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(AppNetwork.self) { resolver in
            return AppNetwork()
        }
        
        container.register(ProductServiceType.self) { resolver in
            let network = resolver.resolve(AppNetwork.self)!
            return ProductService(network: network)
        }
    }
}
