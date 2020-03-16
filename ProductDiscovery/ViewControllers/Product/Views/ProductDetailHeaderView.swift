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

class ProductDetailHeaderView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var sliderView: ImageSlideshow!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var supplierPriceLabel: UILabel!
    @IBOutlet weak var sellPriceLabel: UILabel!
    @IBOutlet weak var discountButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    fileprivate func initialize() {
        Bundle.main.loadNibNamed(String(describing: ProductDetailHeaderView.self), owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = self.bounds
        content.backgroundColor = .white
        content.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(content)
        
        setupSliderView()
    }
    
    func bindData(_ product: Product) {
        let images = product.images.map({ KingfisherSource(urlString: $0.url)! })
        sliderView.setImageInputs(images)
        nameLabel.text = product.name
        codeLabel.text = product.sku
        statusLabel.text = mapTitle(with: product.status.sale)
        supplierPriceLabel.text = product.price.supplierSalePrice.formattedWithDots
        discountButton.isHidden = product.discount == 0
        discountButton.setTitle("-\(product.discount)%", for: .normal)
        
        if product.discount == 0 {
            sellPriceLabel.text = ""
        } else {
            sellPriceLabel.attributedText = product.price.sellPrice.formattedWithDots.strikethroughStyleAttributed
        }
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

extension ProductDetailHeaderView {
    
    private func mapTitle(with status: String) -> String {
        switch status {
        case "ngung_kinh_doanh":
            return "Ngừng kinh doanh"
        case "hang_ban":
            return "Hàng bán"
        case "hang_sap_het":
            return "Hàng sắp hết"
        default:
            return status
        }
    }
}
