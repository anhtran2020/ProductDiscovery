//
//  ProductInfoCell.swift
//  ProductDiscovery
//
//  Created by David Tran on 3/15/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import UIKit
import Domain

class ProductAttributeItemCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(attribute: AttributeGroup, indexPath: IndexPath) {
        titleLabel.text = attribute.name
        valueLabel.text = attribute.value
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        if indexPath.row % 2 == 0 {
            contentView.backgroundColor = .coolGrey
        } else {
            contentView.backgroundColor = .white
        }
    }
}
