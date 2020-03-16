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

class ProductAttributeView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var pagingContainerView: UIView!
    @IBOutlet weak var expandLabel: UILabel!
    @IBOutlet weak var expandImgView: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var expandButton: UIButton!
    @IBOutlet weak var expandStackView: UIStackView!
    @IBOutlet weak var expandBgView: UIView!
    
    var changeHeightAction = PublishRelay<(CGFloat, Bool)>()
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    fileprivate func initialize() {
        Bundle.main.loadNibNamed(String(describing: ProductAttributeView.self), owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = self.bounds
        content.backgroundColor = .white
        content.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(content)
        
        setupViews()
    }
    
    func bindData(_ product: Product) {
        self.product = product
        setupViews()
        pagingViewController.reloadData()
    }
    
    func setupViews() {
        pagingContainerView.addSubview(pagingViewController.view)
        let gradientMaskLayer = CAGradientLayer()
        gradientMaskLayer.frame = gradientView.bounds
        gradientMaskLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
        gradientView.layer.mask = gradientMaskLayer
        
        expandBgView.isHidden = !isShowExpandView()
        gradientView.isHidden = !isShowExpandView()
        
        if !isShowExpandView() {
            changeHeightAction.accept((maxHeightWithoutBottom(), false))
        }
        
        pagingViewController.view.snp.makeConstraints { (maker) in
            maker.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @IBAction func expandButtonTapped(_ sender: Any) {
        expandButton.isSelected = !expandButton.isSelected
        let height = expandButton.isSelected ? maxHeight() : designHeight()
        changeHeightAction.accept((height, true))
        
        expandLabel.text = expandButton.isSelected ? "Hiển thị ít hơn" : "Hiển thị nhiều hơn"
        expandImgView.image = expandButton.isSelected ? #imageLiteral(resourceName: "ic_unexpand") : #imageLiteral(resourceName: "ic_expand")
        gradientView.isHidden = expandButton.isSelected
    }
}

extension ProductAttributeView: PagingViewControllerDataSource {

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

extension ProductAttributeView: PagingViewControllerSizeDelegate {
    
    func pagingViewController(_: PagingViewController, widthForPagingItem pagingItem: PagingItem, isSelected: Bool) -> CGFloat {
        return UIScreen.main.bounds.width/3
    }
}

//MARK: Utilities

extension ProductAttributeView {

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
        let bottomHeight = expandBgView.frame.size.height
        return maxHeightWithoutBottom() + bottomHeight
    }
    
    private func maxHeightWithoutBottom() -> CGFloat {
        let menuHeight = pagingViewController.menuItemSize.height
        let contentHeight = CGFloat(product?.attributeGroups.count ?? 0)*CGFloat(35)
        let padding = CGFloat(10)
        return menuHeight + contentHeight + 2*padding
    }
    
    private func designHeight() -> CGFloat {
        return CGFloat(238)
    }
    
    private func isShowExpandView() -> Bool {
        return maxHeight() > designHeight()
    }
}
