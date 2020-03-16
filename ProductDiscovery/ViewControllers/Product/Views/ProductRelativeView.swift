//
//  ProductRelativeView.swift
//  ProductDiscovery
//
//  Created by David Tran on 3/16/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import UIKit
import Domain
import RxSwift
import RxCocoa

class ProductRelativeView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedProductAction = PublishRelay<Product>()
    
    var products = [Product]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    fileprivate func initialize() {
        Bundle.main.loadNibNamed(String(describing: ProductRelativeView.self), owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = self.bounds
        content.backgroundColor = .white
        content.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(content)
        
        setupViews()
    }
    
    private func setupViews() {
        collectionView.register(UINib(nibName: ProductCollectionViewCell.identifier, bundle: nil),
                                forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
    }
    
    func bindData(products: [Product]) {
        self.products = products
        collectionView.reloadData()
    }
}

extension ProductRelativeView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ofType: ProductCollectionViewCell.self, for: indexPath)
        cell?.configCell(product: products[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
}

extension ProductRelativeView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedProductAction.accept(products[indexPath.row])
    }
}

extension ProductRelativeView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150.0, height: 220.0)
    }
}
