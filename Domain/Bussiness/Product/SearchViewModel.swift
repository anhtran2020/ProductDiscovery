//
//  SearchViewModel.swift
//  Domain
//
//  Created by David Tran on 3/14/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import RxSwift
import RxCocoa

public class SearchViewModel {
    private var service: ProductServiceType!
    private var disposeBag = DisposeBag()
    var pageNumber = 1
    
    public var products = BehaviorSubject<[Product]>(value: [])
    public var reloadingActivity = PublishSubject<Bool>()
    public var loadingMoreActivity = PublishSubject<Bool>()
    public var errorsTracker = PublishSubject<DomainError>()
    
    public init(service: ProductServiceType) {
        self.service = service
    }
    
    public func search(with query: String, action: ReloadAction) {
        if query.isEmpty {
            products.onNext([])
            return
        }
        
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker<String>()
        
        switch action {
        case .reload:
            pageNumber = 1
            service.fetchProducts(query: query, page: pageNumber)
                    .trackActivity("reloading", with: activityTracker)
                    .trackError(errorTracker)
                    .asObservable()
                    .bind(to: reloadBinder)
                    .disposed(by: disposeBag)
            
            errorTracker.asDomain().bind(to: reloadErrorBinder).disposed(by: disposeBag)
            activityTracker.status(for: "reloading").bind(to: reloadingActivity).disposed(by: disposeBag)
        case .loadMore:
            service.fetchProducts(query: query, page: pageNumber)
                    .trackActivity("loadingMore", with: activityTracker)
                    .trackError(errorTracker)
                    .asObservable()
                    .bind(to: loadMoreBinder)
                    .disposed(by: disposeBag)

            errorTracker.asDomain().bind(to: loadMoreErrorBinder).disposed(by: disposeBag)
            activityTracker.status(for: "loadingMore").bind(to: loadingMoreActivity).disposed(by: disposeBag)
        }
    }
}

extension SearchViewModel {
    
    private var reloadBinder: Binder<[Product]> {
        return Binder(self) { (target, results) in
            target.products.onNext(results)
            target.pageNumber += 1
        }
    }
    
    private var reloadErrorBinder: Binder<DomainError> {
        return Binder(self) { (target, error) in
            target.errorsTracker.onNext(error)
        }
    }
    
    private var loadMoreBinder: Binder<[Product]> {
        return Binder(self) { (target, results) in
            let allProducts = target.products.allValue ?? []
            target.products.onNext(allProducts + results)
            target.pageNumber += 1
        }
    }
    
    private var loadMoreErrorBinder: Binder<DomainError> {
        return Binder(self) { (target, error) in
            target.errorsTracker.onNext(error)
        }
    }
}
