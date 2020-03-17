//
//  ProductDetailViewController.swift
//  ProductDiscovery
//
//  Created by David Tran on 3/15/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import UIKit
import Domain
import RxSwift
import RxCocoa

class ProductDetailViewController: BaseViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var topQuantityLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var productHeaderView: ProductDetailHeaderView!
    @IBOutlet weak var attributeGroupView: ProductAttributeView!
    @IBOutlet weak var productRelativeView: ProductRelativeView!
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var productHeaderViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var attributeViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var productRelativeViewHeightConstraint: NSLayoutConstraint!
    
    var viewModel: ProductDetailViewModel!
    var backAction = PublishRelay<Void>()
    var showRelativeProductAction = PublishRelay<Product>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addObservers()
        viewModel.fetchProductDetail()
        viewModel.fetchRelativeProducts()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }

    private func addObservers() {
        backButton.rx.tap.bind(to: backAction).disposed(by: disposeBag)
        viewModel.productDetail.bind(to: reloadBinder).disposed(by: disposeBag)
        viewModel.quantity.bind(to: changeQuantityBinder).disposed(by: disposeBag)
        viewModel.totalPrice.bind(to: changePriceBinder).disposed(by: disposeBag)
        viewModel.relativeProducts.bind(to: loadedRelativeProductBinder).disposed(by: disposeBag)
        viewModel.reloadingActivity.bind(to: reloadingHUDBinder).disposed(by: disposeBag)
        viewModel.errorsTracker.bind(to: errorBinder).disposed(by: disposeBag)
        
        attributeGroupView.changeHeightAction.bind(to: attributeChangeHeightBinder).disposed(by: disposeBag)
        productRelativeView.selectedProductAction.bind(to: showRelativeProductAction).disposed(by: disposeBag)
    }
    
    private func setupViews() {
        nameLabel.text = viewModel.product.name
        priceLabel.text = viewModel.product.price.supplierSalePrice.formattedWithDotsAndDefaultUnit
        headerViewHeightConstraint.constant = HeaderViewConstant.height + view.windowSafeAreaInsets.top
        bottomViewHeightConstraint.constant = FooterViewConstant.height + view.windowSafeAreaInsets.bottom
        productHeaderViewHeightConstraint.constant = (UIScreen.main.bounds.width * 492)/414
    }
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        viewModel.plusQuantity()
    }
    
    @IBAction func minusButtonTapped(_ sender: Any) {
        viewModel.minusQuantity()
    }
    
    private func expandAttributeViewAnimation() {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.view.layoutIfNeeded()
        }, completion: { [weak self] _ in
            self?.autoScrollToAttributeViewIfNeed()
        })
    }
    
    private func autoScrollToAttributeViewIfNeed() {
        scrollView.scrollRectToVisible(attributeGroupView.frame, animated: true)
    }
}

extension ProductDetailViewController {
    
    private var attributeChangeHeightBinder: Binder<(CGFloat, Bool)> {
        return Binder(self) { (target, expand) in
            target.attributeViewHeightConstraint.constant = expand.0
            if expand.1 {
                target.expandAttributeViewAnimation()
            }
        }
    }
    
    private var reloadBinder: Binder<Product> {
        return Binder(self) { (target, product) in
            target.productHeaderView.bindData(product)
            target.attributeGroupView.bindData(product)
        }
    }
    
    private var loadedRelativeProductBinder: Binder<[Product]> {
        return Binder(self) { (target, products) in
            target.productRelativeView.bindData(products: products)
        }
    }
    
    private var changeQuantityBinder: Binder<Int> {
        return Binder(self) { (target, quantity) in
            target.quantityLabel.text = "\(quantity)"
            target.topQuantityLabel.text = "\(quantity)"
        }
    }
    
    private var changePriceBinder: Binder<Double> {
        return Binder(self) { (target, price) in
            target.totalPriceLabel.text = price.formattedWithDotsAndDefaultUnit
        }
    }
    
    private var reloadingHUDBinder: Binder<Bool> {
        return Binder(self) { (target, isReloading) in
            if isReloading {
                LoadingIndicator.shared.showAdd(to: target.view)
            } else {
                LoadingIndicator.shared.hide(for: target.view)
            }
        }
    }
    
    private var errorBinder: Binder<DomainError> {
        return Binder(self) { (target, error) in
            AlertView.shared.presentSimpleAlert(title: "Error", message: error.localizedDescription)
        }
    }
}
