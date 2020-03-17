//
//  ProductViewModelTests.swift
//  DomainTests
//
//  Created by Anh Tran on 3/17/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import XCTest
@testable import Domain

class ProductViewModelTests: XCTestCase {
    
    var viewModel: ProductViewModel!
    
    override func setUp() {
        viewModel = ProductViewModel(service: ProductServiceMock())
    }

    override func tearDown() {

    }

    func testPerformanceExample() {
        self.measure {
            
        }
    }
    
    func testFetchProducts() {
        XCTAssertEqual(viewModel.pageNumber, 1)
        
        viewModel.fetchProduct(action: .reload)
        
        XCTAssertEqual(viewModel.pageNumber, 2)
        XCTAssertEqual(viewModel.products.allValue?.count, 3)
    }
    
    func testLoadMoreProducts() {
        viewModel.fetchProduct(action: .reload)
        
        XCTAssertEqual(viewModel.pageNumber, 2)
        
        viewModel.fetchProduct(action: .loadMore)
        
        XCTAssertEqual(viewModel.pageNumber, 3)
        XCTAssertEqual(viewModel.products.allValue?.count, 6)
    }
}
