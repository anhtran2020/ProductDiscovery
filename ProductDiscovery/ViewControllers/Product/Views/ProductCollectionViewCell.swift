//
//  ProductCollectionViewCell.swift
//  ProductDiscovery
//
//  Created by David Tran on 3/16/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import UIKit
import Domain
import Kingfisher

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sellPriceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var discountButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(product: Product) {
        let price = product.price.sellPrice
        let supplierPrice = product.price.supplierSalePrice
        
        imgView.kf.setImage(with: URL(string: product.images.first?.url ?? ""), placeholder: #imageLiteral(resourceName: "ic_placeholder"))
        nameLabel.text = product.name
        sellPriceLabel.text = supplierPrice.formattedWithDots
        discountButton.isHidden = product.discount == 0
        discountButton.setTitle("-\(product.discount)%", for: .normal)

        if product.discount == 0 {
            priceLabel.text = ""
        } else {
            priceLabel.attributedText = price.formattedWithDots.strikethroughStyleAttributed
        }
    }
}
