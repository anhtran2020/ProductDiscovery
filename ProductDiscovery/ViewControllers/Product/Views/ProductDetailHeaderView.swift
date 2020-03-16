//
//  ProductDetailHeaderView.swift
//  ProductDiscovery
//
//  Created by David Tran on 3/15/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import UIKit
import Domain
import Kingfisher
import ImageSlideshow

class ProductDetailHeaderView: UICollectionReusableView {

    @IBOutlet weak var sliderView: ImageSlideshow!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var supplierPriceLabel: UILabel!
    @IBOutlet weak var sellPriceLabel: UILabel!
    @IBOutlet weak var discountButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindData(_ product: Product) {
        let images = product.images.map({ KingfisherSource(urlString: $0.url)! })
        
        setupSliderView()
        sliderView.setImageInputs(images)
        nameLabel.text = product.name
        codeLabel.text = product.sku
        statusLabel.text = product.status.sale
        supplierPriceLabel.text = product.price.supplierSalePrice.formattedWithDots
        sellPriceLabel.text = product.discount == 0 ? "" : product.price.sellPrice.formattedWithDots
        discountButton.isHidden = product.discount == 0
        discountButton.setTitle("-\(product.discount)%", for: .normal)
    }
    
    private func setupSliderView() {
        sliderView.slideshowInterval = 5.0
        sliderView.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        sliderView.contentScaleMode = UIViewContentMode.scaleAspectFit

        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.8745098039, green: 0.1254901961, blue: 0.1254901961, alpha: 1)
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.9333333333, green: 0.9450980392, blue: 0.9529411765, alpha: 1)
        sliderView.pageIndicator = pageControl
    }
}
