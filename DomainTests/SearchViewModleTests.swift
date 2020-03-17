//
//  SearchViewModleTests.swift
//  DomainTests
//
//  Created by Anh Tran on 3/17/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import XCTest
@testable import Domain

class SearchViewModleTests: XCTestCase {
    
    var viewModel: SearchViewModel!
    
    override func setUp() {
        viewModel = SearchViewModel(service: ProductServiceMock())
    }

    override func tearDown() {

    }

    func testPerformanceExample() {
        self.measure {
            
        }
    }
    
    func testSearchProducts() {
        XCTAssertEqual(viewModel.pageNumber, 1)
        
        viewModel.search(with: "a", action: .reload)
        
        XCTAssertEqual(viewModel.pageNumber, 2)
        XCTAssertEqual(viewModel.products.allValue?.count, 3)
    }
    
    func testLoadMoreProducts() {
        viewModel.search(with: "a", action: .reload)
        
        XCTAssertEqual(viewModel.pageNumber, 2)
        
        viewModel.search(with: "a", action: .loadMore)
        
        XCTAssertEqual(viewModel.pageNumber, 3)
        XCTAssertEqual(viewModel.products.allValue?.count, 6)
    }
}
