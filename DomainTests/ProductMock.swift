//
//  ProductMock.swift
//  DomainTests
//
//  Created by Anh Tran on 3/17/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import UIKit
@testable  import Domain
@testable  import NetworkModule

class ProductMock {
    
    var jsonProductReader: Data {
        return jsonFrom(file: "products")
    }
    
    func jsonProductDecoder() -> [Product] {
        do {
            let products = try JSONDecoder().decode([ProductModel].self, from: jsonProductReader)
            return products.asDomain()
        } catch {
            
        }
        return []
    }
}

extension ProductMock {
    
    var jsonProductDetailReader: Data {
        return jsonFrom(file: "product_detail")
    }
    
    func jsonProductDetailDecoder() -> Product? {
        do {
            let product = try JSONDecoder().decode(ProductDetailModel.self, from: jsonProductDetailReader)
            return product.asDomain()
        } catch {
            
        }
        return nil
    }
}

extension ProductMock {
    
    func jsonFrom(file: String) -> Data {
        if let path = Bundle(for: type(of: self)).path(forResource: file, ofType: "json") {
            do {
                return try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            } catch {
                
            }
        }
        return Data()
    }
}
