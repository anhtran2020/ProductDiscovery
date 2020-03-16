//
//  ProductDetailViewModel.swift
//  Domain
//
//  Created by David Tran on 3/15/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import RxSwift
import RxCocoa

public class ProductDetailViewModel {
    private var service: ProductServiceType!
    public var product: Product!
    
    private var disposeBag = DisposeBag()
    public var productDetail = PublishSubject<Product>()
    public var reloadingActivity = PublishSubject<Bool>()
    public var errorsTracker = PublishSubject<DomainError>()
    
    public init(service: ProductServiceType, product: Product?) {
        self.service = service
        self.product = product
    }
    
    public func fetchProductDetail() {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker<String>()

        service.fetchProductDetail(sku: product.sku)
                .trackActivity("reloading", with: activityTracker)
                .trackError(errorTracker)
                .asObservable()
                .bind(to: reloadBinder)
                .disposed(by: disposeBag)
        
        errorTracker.asDomain().bind(to: reloadErrorBinder).disposed(by: disposeBag)
        activityTracker.status(for: "reloading").bind(to: reloadingActivity).disposed(by: disposeBag)
    }
    
    private var reloadBinder: Binder<Product> {
        return Binder(self) { (target, product) in
            target.product = product
            target.productDetail.onNext(product)
        }
    }
    
    private var reloadErrorBinder: Binder<DomainError> {
        return Binder(self) { (target, error) in
            target.errorsTracker.onNext(error)
        }
    }
}
