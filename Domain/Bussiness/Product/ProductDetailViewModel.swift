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
    public var relativeProducts = BehaviorSubject<[Product]>(value: [])
    public var productDetail = PublishSubject<Product>()
    public var reloadingActivity = PublishSubject<Bool>()
    public var errorsTracker = PublishSubject<DomainError>()
    public var quantity = BehaviorSubject<Int>(value: 0)
    public var totalPrice = BehaviorSubject<Double>(value: 0)
    
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
    
    public func fetchRelativeProducts() {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker<String>()

        service.fetchProducts(query: "", page: 1)
                .trackActivity("reloading", with: activityTracker)
                .trackError(errorTracker)
                .asObservable()
                .bind(to: productRelativeFetchBinder)
                .disposed(by: disposeBag)
        
        errorTracker.asDomain().bind(to: relativeProductErrorBinder).disposed(by: disposeBag)
        activityTracker.status(for: "reloading").bind(to: reloadingActivity).disposed(by: disposeBag)
    }
    
    public func plusQuantity() {
        let allQuantity = (quantity.allValue ?? 0) + 1
        quantity.onNext(allQuantity)
        totalPrice.onNext(Double(allQuantity) * product.price.supplierSalePrice)
    }
    
    public func minusQuantity() {
        let allQuantity = (quantity.allValue ?? 0) - 1
        if allQuantity >= 0 {
            quantity.onNext(allQuantity)
            totalPrice.onNext(Double(allQuantity) * product.price.supplierSalePrice)
        }
    }
}

extension ProductDetailViewModel {
    
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
    
    private var productRelativeFetchBinder: Binder<[Product]> {
        return Binder(self) { (target, products) in
            target.relativeProducts.onNext(products)
        }
    }
    
    private var relativeProductErrorBinder: Binder<DomainError> {
        return Binder(self) { (target, error) in
            target.errorsTracker.onNext(error)
        }
    }
}
