//
//  Single+Mapping.swift
//  NetworkModule
//
//  Created by David Tran on 3/13/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation
import RxSwift
import Domain

extension PrimitiveSequenceType where Trait == SingleTrait, Element: DomainConvertible {
    func mapToDomain() -> Single<Element.DomainType> {
        return map { $0.asDomain() }
    }
}
