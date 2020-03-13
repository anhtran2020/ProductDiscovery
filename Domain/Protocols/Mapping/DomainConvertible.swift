//
//  DomainConvertible.swift
//  Domain
//
//  Created by David Tran on 3/13/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

public protocol DomainConvertible {
    associatedtype DomainType
    func asDomain() -> DomainType
}
