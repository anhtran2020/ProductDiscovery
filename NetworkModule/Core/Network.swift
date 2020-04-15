//
//  Network.swift
//  NetworkModule
//
//  Created by David Tran on 3/13/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

struct RequestConvertible: URLRequestConvertible {
    let configuration: NetworkConfiguration
    let endpoint: EndpointConvertible
    
    func asURLRequest() throws -> URLRequest {
        try endpoint.asURLRequest(configuration: configuration)
    }
}

public class Network {
    
    let configuration: NetworkConfiguration
    let session: Session
    
    init(configuration: NetworkConfiguration, session: Session = Alamofire.Session.default) {
        self.configuration = configuration
        self.session = Session(startRequestsImmediately: false,
                               interceptor: nil,
                               serverTrustManager: nil,
                               cachedResponseHandler: ResponseCacher(behavior: .doNotCache))
    }
}

extension Network: ReactiveCompatible {}

extension Reactive where Base: Network {
    
    func request(with endpoint: EndpointConvertible) -> Single<DataRequest> {
        return request(with: RequestConvertible(configuration: base.configuration, endpoint: endpoint))
    }
    
    func request(with request: RequestConvertible) -> Single<DataRequest> {
        return Single.create { [session = base.session] callback -> Disposable in
            callback(.success(session.request(request)))
            return Disposables.create()
        }
    }
}
