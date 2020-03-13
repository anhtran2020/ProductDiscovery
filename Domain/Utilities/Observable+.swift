//
//  Observable+.swift
//  Domain
//
//  Created by David Tran on 3/13/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import RxSwift

extension ObservableType where Element == Bool {
    
    static var createBoolean: Observable<Bool> {
        return Observable<Bool>.create { observer -> Disposable in
            observer.onNext(false)
            return Disposables.create()
        }
    }
}

extension BehaviorSubject {
    
    public var allValue: Element? {
        do {
            return try self.value()
        } catch {
            return nil
        }
    }
}
