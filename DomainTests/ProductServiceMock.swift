//
//  ProductServiceMock.swift
//  DomainTests
//
//  Created by Anh Tran on 3/17/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
@testable import Domain

class ProductServiceMock: ProductServiceType {
    
    func fetchProductDetail(sku: String) -> Single<Product> {
        return Single.create { (callback) -> Disposable in
            if let product = ProductMock().jsonProductDetailDecoder() {
                callback(.success(product))
            }
            return Disposables.create()
        }
    }
    
    
    func fetchProducts(query: String, page: Int) -> Single<[Product]> {
        return Single.create { (callback) -> Disposable in
            callback(.success(ProductMock().jsonProductDecoder()))
            return Disposables.create()
        }
    }
}
