//
//  NSObject+.swift
//  ProductDiscovery
//
//  Created by David Tran on 3/12/20.
//  Copyright © 2020 David Tran. All rights reserved.
//

import Foundation

extension NSObject {
    
    class var identifier: String {
        return String(describing: self)
    }
}
