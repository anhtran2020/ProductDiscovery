//
//  ProductViewModel.swift
//  Domain
//
//  Created by David Tran on 3/13/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import RxSwift
import RxCocoa

public enum ReloadAction {
    case reload
    case loadMore
}

public class ProductViewModel {

    var service: ProductServiceable
    var pageNumber = 1
    var disposeBag = DisposeBag()
    
    public var products = BehaviorSubject<[Product]>(value: [])
    public var moreProducts = PublishSubject<[Product]>()
    
    public var reloadingActivity = PublishSubject<Bool>()
    public var loadingMoreActivity = PublishSubject<Bool>()
    public var errorsTracker = PublishSubject<DomainError>()
    
    public init(service: ProductServiceable) {
        self.service = service
    }
    
    public func fetchProduct(action: ReloadAction) {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker<String>()
        
        switch action {
        case .reload:
            pageNumber = 1
            service.fetchProducts(query: "", page: pageNumber)
                    .trackActivity("reloading", with: activityTracker)
                    .trackError(errorTracker).asObservable().bind(to: reloadBinder).disposed(by: disposeBag)
            
            activityTracker.status(for: "reloading").bind(to: reloadingActivity).disposed(by: disposeBag)
        case .loadMore:
            service.fetchProducts(query: "", page: pageNumber)
                    .trackActivity("loadingMore", with: activityTracker)
                    .trackError(errorTracker)
                    .asObservable()
                    .bind(to: reloadBinder).disposed(by: disposeBag)
            
            activityTracker.status(for: "loadingMore").bind(to: loadingMoreActivity).disposed(by: disposeBag)
        }
        
        errorTracker.asDomain().bind(to: errorsTracker).disposed(by: disposeBag)
    }
    
    public func reloadProducts() -> Single<[Product]> {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker<String>()
        pageNumber = 0
        
        let result = service.fetchProducts(query: "", page: pageNumber)
                        .trackActivity("reloading", with: activityTracker)
                        .trackError(errorTracker)
        
        errorTracker.asDomain().bind(to: errorsTracker).disposed(by: disposeBag)
        activityTracker.status(for: "reloading").bind(to: reloadingActivity).disposed(by: disposeBag)
        return result
    }
    
    public func loadMoreProducts() -> Single<[Product]> {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker<String>()
        pageNumber += 1
        
        let result = service.fetchProducts(query: "", page: pageNumber)
                        .trackActivity("loadingMore", with: activityTracker)
                        .trackError(errorTracker)
        
        errorTracker.asDomain().bind(to: errorsTracker).disposed(by: disposeBag)
        activityTracker.status(for: "loadingMore").bind(to: loadingMoreActivity).disposed(by: disposeBag)
        return result
    }
    
    private var reloadBinder: Binder<[Product]> {
        return Binder(self) { (target, products) in
            target.products.onNext(products)
            target.pageNumber += 1
        }
    }
    
    private var loadMoreBinder: Binder<[Product]> {
        return Binder(self) { (target, results) in
            let allProducts = target.products.allValue ?? []
            target.products.onNext(allProducts + results)
            target.pageNumber += 1
        }
    }
}
