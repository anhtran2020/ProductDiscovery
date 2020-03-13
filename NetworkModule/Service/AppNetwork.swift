//
//  AppNetwork.swift
//  NetworkModule
//
//  Created by David Tran on 3/13/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Domain

public class AppNetwork: Network {
    
    public init() {
        super.init(configuration: NetworkConfiguration(baseURL: baseURL))
    }
}

extension AppNetwork {
    
    public func productService() -> ProductServiceable {
        return ProductService(network: self)
    }
}
