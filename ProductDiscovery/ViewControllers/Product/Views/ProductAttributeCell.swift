//
//  ProductAttributeCell.swift
//  ProductDiscovery
//
//  Created by Anh Tran on 3/16/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Parchment
import SnapKit
import Domain

class ProductAttributeCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var expandLabel: UILabel!
    @IBOutlet weak var expandImgView: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var expandButton: UIButton!
    @IBOutlet weak var expandStackView: UIStackView!
    @IBOutlet weak var expandBgView: UIView!
    
    var expandAction = PublishRelay<(CGFloat, Bool)>()
    
    private lazy var pagingViewController: PagingViewController = {
        let controller = PagingViewController()
        controller.font = UIFont.regularDesignFont(ofSize: 13)
        controller.selectedFont = UIFont.regularDesignFont(ofSize: 13)
        controller.textColor = .coolGrey
        controller.selectedTextColor = .darkGrey
        controller.indicatorColor = .reddishOrange
        controller.dataSource = self
        controller.sizeDelegate = self
        return controller
    }()
    
    var product: Product?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(product: Product) {
        self.product = product
        setupViews()
        pagingViewController.reloadData()
    }
    
    func setupViews() {
        self.addSubview(pagingViewController.view)
//        let gradientMaskLayer = CAGradientLayer()
//        gradientMaskLayer.frame = gradientView.bounds
//        gradientMaskLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
////        gradientMaskLayer.locations = [0, 0.1, 0.9, 1]
//        gradientView.layer.mask = gradientMaskLayer
        
        expandButton.isHidden = !isShowExpandView()
        expandStackView.isHidden = !isShowExpandView()
        expandButton.isHidden = !isShowExpandView()
        
        pagingViewController.view.snp.makeConstraints { (maker) in
            maker.top.leading.trailing.equalToSuperview()
            maker.bottom.equalToSuperview().inset(42)
        }
    }
    
    @IBAction func expandButtonTapped(_ sender: Any) {
        let isExpanded = product?.isExpanded == true
        let height = isExpanded ? designHeight() : maxHeight()
        expandAction.accept((height, isExpanded))
    }
}

extension ProductAttributeCell: PagingViewControllerDataSource {

    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        return 3
    }
    
    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        let attributeVC = UIViewController.instantiateViewController(fromStoryboard: .product, ofType: ProductAttributeViewController.self)
        attributeVC.attributeGroups = product?.attributeGroups ?? []
        return attributeVC
    }
    
    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        return PagingIndexItem(index: index, title: title(for: index))
    }
}

// MARK: - PagingViewControllerDelegate

extension ProductAttributeCell: PagingViewControllerSizeDelegate {
    
    func pagingViewController(_: PagingViewController, widthForPagingItem pagingItem: PagingItem, isSelected: Bool) -> CGFloat {
        guard let item = pagingItem as? PagingIndexItem else { return 0 }

        let insets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: pagingViewController.menuItemSize.height)
        let attributes = [NSAttributedString.Key.font: pagingViewController.font]

        let rect = item.title.boundingRect(with: size,
                                           options: .usesLineFragmentOrigin,
                                           attributes: attributes,
                                           context: nil)

        return ceil(rect.width) + insets.left + insets.right
    }
}

//MARK: Utilities

extension ProductAttributeCell {
    private func title(for index: Int) -> String {
        switch index {
        case 0:
            return "Mô tả sản phẩm"
        case 1:
            return "Thông số kỹ thuật"
        case 2:
            return "So sánh giá"
        default:
            return ""
        }
    }
    
    private func maxHeight() -> CGFloat {
        let menuHeight = pagingViewController.menuItemSize.height
        let contentHeight = CGFloat(product?.attributeGroups.count ?? 0)*CGFloat(35)
        let bottomHeight = expandBgView.frame.size.height
        return menuHeight + contentHeight + bottomHeight
    }
    
    private func designHeight() -> CGFloat {
        return CGFloat(238)
    }
    
    private func isShowExpandView() -> Bool {
        return maxHeight() > designHeight()
    }
}
