//
//  Network.swift
//  NetworkModule
//
//  Created by David Tran on 3/13/20.
//  Copyright © 2020 Teko. All rights reserved.
//

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
    private var session: Session
    
    init(configuration: NetworkConfiguration) {
        self.configuration = configuration
        self.session = Session()
    }

    func request(with endpoint: EndpointConvertible) -> Single<DataRequest> {
        return request(with: RequestConvertible(configuration: configuration, endpoint: endpoint))
    }
    
    func request(with request: RequestConvertible) -> Single<DataRequest> {
        return Single.create { callback -> Disposable in
            callback(.success(Alamofire.Session.default.request(request)))
            return Disposables.create()
        }
    }
}
