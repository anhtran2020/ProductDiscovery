//
//  RxSwift+.swift
//  TheNewBase
//
//  Created by David Tran on 10/13/19.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension BehaviorSubject {
    
    public var value: Element? {
        do {
            return try self.value()
        } catch {
            return nil
        }
    }
}

extension Reactive where Base: UIScrollView {
    public var contentSize: Observable<CGSize> {
        return self.observeWeakly(keyPath: \.contentSize, options: [.initial, .new]).flatMap { size -> Observable<CGSize> in
            guard let size = size else {
                return Observable<CGSize>.empty()
            }
            return Observable<CGSize>.just(size)
        }
    }
}

extension Reactive where Base: NSObject {
    public func observeWeakly<Value>(keyPath: KeyPath<Base, Value>, options: KeyValueObservingOptions = [.new, .initial]) -> Observable<Value?> {
        guard let keyPathString = keyPath._kvcKeyPathString else {
            return Observable.error(RxCocoaError.invalidObjectOnKeyPath(object: base, sourceObject: keyPath, propertyName: base.description))
        }
        return self.observeWeakly(Value.self, keyPathString, options: options)
    }
}
