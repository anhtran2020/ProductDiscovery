//
//  ProductDetailViewModel.swift
//  Domain
//
//  Created by David Tran on 3/15/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import RxSwift

public class ProductDetailViewModel {
    private var service: ProductServiceType!
    public var product: Product!
    
    public init(service: ProductServiceType, product: Product?) {
        self.service = service
        self.product = product
    }
}
