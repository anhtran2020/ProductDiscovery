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
        return network.rx
            .request(with: Router.products(query: query, page: page))
            .validate()
            .responseParser(of: ProductObject.self)
            .map { $0.products.asDomain() }
    }
    
    public func fetchProductDetail(sku: String) -> Single<Product> {
        return network.rx
            .request(with: Router.productDetail(sku: sku))
            .validate()
            .responseDecodable(of: ProductDetailModel.self, keyPath: "result.product")
            .mapToDomain()
    }
}

