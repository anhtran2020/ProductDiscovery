//
//  ProductServiceType.swift
//  Domain
//
//  Created by David Tran on 3/13/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import RxSwift

public protocol ProductServiceable {
    func fetchProducts(query: String, page: Int) -> Single<[Product]>
}
