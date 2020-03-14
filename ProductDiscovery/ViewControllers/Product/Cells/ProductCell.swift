//
//  ProductCell.swift
//  ProductDiscovery
//
//  Created by David Tran on 3/13/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import UIKit
import Domain
import Kingfisher

class ProductCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sellPriceLabel: UILabel!
    @IBOutlet weak var discountButton: UIButton!
    @IBOutlet weak var unitLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configCell(_ product: Product) {
        let supplierPrice = product.price.supplierSalePrice ?? 0
        let price = product.price.sellPrice ?? 0
        
        imgView.kf.setImage(with: URL(string: product.images.first?.url ?? ""), placeholder: #imageLiteral(resourceName: "ic_placeholder"))
        nameLabel.text = product.name
        priceLabel.text = supplierPrice.formattedWithDots
        sellPriceLabel.text = product.discount == 0 ? "" : "\(price.formattedWithDots)"
        discountButton.isHidden = product.discount == 0
        discountButton.setTitle("-\(product.discount)%", for: .normal)
    }
}
