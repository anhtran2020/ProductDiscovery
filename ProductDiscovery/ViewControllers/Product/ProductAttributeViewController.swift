//
//  ProductAttributeViewController.swift
//  ProductDiscovery
//
//  Created by Anh Tran on 3/16/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import UIKit
import Domain

class ProductAttributeViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var attributeGroups = [AttributeGroup]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ProductAttributeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attributeGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: ProductAttributeItemCell.self, for: indexPath)
        cell?.configCell(attribute: attributeGroups[indexPath.row], indexPath: indexPath)
        return cell ?? UITableViewCell()
    }
}

extension ProductAttributeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35.0
    }
}
