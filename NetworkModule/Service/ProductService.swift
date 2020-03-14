//
//  ProductService.swift
//  NetworkModule
//
//  Created by David Tran on 3/13/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import RxSwift
import Domain

public struct ProductService {
    let network: Network
    
    public init(network: Network) {
        self.network = network
    }
}

extension ProductService: ProductServiceType {
    
    public func fetchProducts(query: String, page: Int) -> Single<[Product]> {
        return network
            .request(with: Router.products(query: query, page: page))
            .responseDecodable(of: [ProductModel].self, keyPath: "result.products")
            .mapToDomain()
    }
}

