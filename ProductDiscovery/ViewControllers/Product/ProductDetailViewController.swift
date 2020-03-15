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
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomViewHeightConstraint: NSLayoutConstraint!
    
    var viewModel: ProductDetailViewModel!
    var backAction = PublishRelay<Void>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addObservers()
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
    }
    
    private func setupViews() {
        nameLabel.text = viewModel.product.name
        priceLabel.text = viewModel.product.price.supplierSalePrice.formattedWithDotsWithDefaultUnit
        headerViewHeightConstraint.constant = HeaderViewConstant.height + view.windowSafeAreaInsets.top
        bottomViewHeightConstraint.constant = FooterViewConstant.height + view.windowSafeAreaInsets.bottom
    }
    
    @IBAction func plusButtonTapped(_ sender: Any) {
    
    }
    
    @IBAction func minusButtonTapped(_ sender: Any) {
    
    }
}

extension ProductDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductInfoCell.identifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                         withReuseIdentifier: ProductDetailHeaderView.identifier,
                                                                         for: indexPath) as! ProductDetailHeaderView
        headerView.frame.size.height = (UIScreen.main.bounds.width * 492)/414
        headerView.bindData(viewModel.product)
        
        return headerView
    }
}
