//
//  Single+DataRequest.swift
//  NetworkModule
//
//  Created by David Tran on 3/13/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import RxSwift
import Alamofire
import Domain

extension PrimitiveSequenceType where Element: DataRequest, Trait == SingleTrait {
    func responseDecodable<T: Decodable>(of type: T.Type = T.self,
                                         keyPath: String,
                                         decoder: DataDecoder = JSONDecoder(),
                                         jsonReadingOptions: JSONSerialization.ReadingOptions = .allowFragments) -> Single<T> {
        return responseDecodable(of: type, decoder: NestedJSONDecoder(keyPath: keyPath, decoder: decoder, readingOptions: jsonReadingOptions))
    }
    
    func responseDecodable<T: Decodable>(of type: T.Type = T.self, decoder: DataDecoder = JSONDecoder()) -> Single<T> {
        return flatMap { (request) -> Single<T> in
            return Single.create { (single) -> Disposable in
                let request = request.responseDecodable(of: type, decoder: decoder) { (response) in
                    switch response.result {
                    case .success(let value):
                        single(.success(value))
                    case .failure(let error):
                        single(.error(error.asDomainError()))
                    }
                }
                request.resume()
                return Disposables.create {
                    request.cancel()
                }
            }
        }
    }
}
