//
//  NetworkError.swift
//  NetworkModule
//
//  Created by David Tran on 3/13/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Domain
import Alamofire

enum NetworkError: Error {
    enum ResponseSerializationFailureReason {
        case nilDataAtKeyPath(keyPath: String)
        case invalidJSONAtKeyPath(keyPath: String?, value: Any)
    }
    
    case responseSerializationFailed(reason: ResponseSerializationFailureReason)
    case tokenExpired
    case serverFailure
    case noResponseDataToParse
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .responseSerializationFailed(let reason):
            return reason.localizedDescription
        case .tokenExpired:
            return "Token expired"
        case .serverFailure:
            return "Server failure"
        case .noResponseDataToParse:
            return "No response data to parse"
        }
    }
}

extension NetworkError.ResponseSerializationFailureReason {
    var localizedDescription: String? {
        switch self {
        case .nilDataAtKeyPath(let keyPath):
            return "Network: Parsing JSON data failed - nil data at keypath: \(keyPath)"
        case .invalidJSONAtKeyPath(let keyPath, let value):
            guard let keyPath = keyPath else {
                return "Network: Parsing JSON data failed - invalid JSON value: \(value)"
            }

            return "Network: Parsing JSON data failed - invalid JSON at keypath: \(keyPath), value: \(value)"
        }
    }
}

//MARK: Mapping

extension NetworkError: DomainErrorConvertible {
    func asDomainError() -> DomainError {
        switch self {
        case .serverFailure:
            return DomainError.serverFailure
        default:
            return .other(error: self)
        }
    }
}

extension AFError: DomainErrorConvertible {
    public func asDomainError() -> DomainError {
        if let error = self.underlyingError as NSError?, error.domain == NSURLErrorDomain {
            if error.code == -1009 {
                return .lostInternetConnection
            }
            return .other(error: error)
        }
        
        return (self.underlyingError as? DomainErrorConvertible)?.asDomainError() ?? .other(error: self)
    }
}
