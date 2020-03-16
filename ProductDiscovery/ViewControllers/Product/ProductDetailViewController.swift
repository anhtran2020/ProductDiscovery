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
    var attributeCellHeight = CGFloat(238)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addObservers()
        viewModel.fetchProductDetail()
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

extension ProductDetailViewController {
    
    private var reloadBinder: Binder<Product> {
        return Binder(self) { (target, _) in
            target.collectionView.reloadData()
        }
    }
    
    private var expandCellBinder: Binder<(CGFloat, Bool)> {
        return Binder(self) { (target, expand) in
            target.attributeCellHeight = expand.0
            target.viewModel.product.isExpanded = !expand.1
            UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                  target.collectionView.reloadItems(at: [IndexPath(row: 0, section: 0)])
                }, completion: { success in
                    print("success")
            })
//            target.collectionView.reloadItems(at: [IndexPath(row: 0, section: 0)])
        }
    }
}

extension ProductDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ofType: ProductAttributeCell.self, for: indexPath)
        cell?.configCell(product: viewModel.product)
        cell?.expandAction.bind(to: expandCellBinder).disposed(by: disposeBag)
        return cell ?? UICollectionViewCell()
    }
        
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                         withReuseIdentifier: ProductDetailHeaderView.identifier,
                                                                         for: indexPath) as! ProductDetailHeaderView

        headerView.bindData(viewModel.product)
 
        return headerView
    }
}

extension ProductDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: attributeCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.width * 492)/414)
    }
}
