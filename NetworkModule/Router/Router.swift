//
//  Router.swift
//  NetworkModule
//
//  Created by David Tran on 3/13/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Alamofire

enum Router: EndpointConvertible {

    case products(query: String, page: Int)
    case productDetail(sku: String)
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .products:
            return "api/search/"
        case .productDetail(let sku):
            return "api/products/\(sku)"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .products(let query, let page):
            return ["channel": "pv_online", "q": query, "_page": page, "_limit": 20, "visitorId": "", "terminal": "CP01"]
        case .productDetail:
            return ["channel": "pv_online", "terminal": "CP01"]
        }
    }
}
