//
//  DomainError.swift
//  Domain
//
//  Created by David Tran on 3/13/20.
//  Copyright © 2020 Teko. All rights reserved.
//

public enum DomainError: Error {
    case other(error: Error)
    case lostInternetConnection
    case serverFailure
}

//MARK: - Mapping

public protocol DomainErrorConvertible {
    func asDomainError() -> DomainError
}

extension DomainError: DomainErrorConvertible {
    public func asDomainError() -> DomainError {
        return self
    }
}

extension Error {
    func asDomainError() -> DomainError {
        (self as? DomainErrorConvertible)?.asDomainError() ?? .other(error: self)
    }
}
