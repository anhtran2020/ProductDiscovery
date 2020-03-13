//
//  Sequence+Mapping.swift
//  NetworkModule
//
//  Created by David Tran on 3/13/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Domain

extension Array: DomainConvertible where Element: DomainConvertible {
    public func asDomain() -> Array<Element.DomainType> {
        return map { $0.asDomain() }
    }
}
