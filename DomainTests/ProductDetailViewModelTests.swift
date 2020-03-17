//
//  ProductDetailViewModelTests.swift
//  DomainTests
//
//  Created by Anh Tran on 3/17/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import XCTest
@testable import Domain

class ProductDetailViewModelTests: XCTestCase {
    
    var viewModel: ProductDetailViewModel!
    
    override func setUp() {
        viewModel = ProductDetailViewModel(service: ProductServiceMock(),
                                           product: ProductMock().jsonProductDetailDecoder())
    }

    override func tearDown() {

    }

    func testPerformanceExample() {
        self.measure {
            
        }
    }
    
    func testFetchProductDetail() {
        viewModel.fetchProductDetail()
        
        XCTAssertEqual(viewModel.product.sku, "1200010")
        XCTAssertEqual(viewModel.product.name, "ADSL Draytek V120")
    }
    
    func testFetchRelativeProducts() {
        viewModel.fetchRelativeProducts()
        
        XCTAssertEqual(viewModel.relativeProducts.allValue?.count, 3)
    }
    
    func testPlusQuantity() {
        XCTAssertEqual(viewModel.quantity.allValue, 0)
        
        viewModel.plusQuantity()
        
        XCTAssertEqual(viewModel.quantity.allValue, 1)
    }
    
    func testMinusQuantity() {
        XCTAssertEqual(viewModel.quantity.allValue, 0)
        
        viewModel.minusQuantity()
        
        XCTAssertEqual(viewModel.quantity.allValue, 0)
        
        viewModel.plusQuantity()
        viewModel.plusQuantity()
        viewModel.minusQuantity()
        
        XCTAssertEqual(viewModel.quantity.allValue, 1)
    }
}
