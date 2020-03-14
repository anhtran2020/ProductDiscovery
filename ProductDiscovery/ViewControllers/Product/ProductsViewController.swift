//
//  ProductsViewController.swift
//  ProductDiscovery
//
//  Created by David Tran on 3/13/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import UIKit
import Domain
import Network
import RxSwift
import RxCocoa
import CRRefresh
import Swinject

class ProductViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ProductViewModel!
    var showSearchBar = PublishRelay<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addObservers()
        tableView.cr.beginHeaderRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupView() {
        self.navigationController?.navigationBar.isHidden = true
        
        tableView.cr.addHeadRefresh { [weak self] in
            self?.viewModel.fetchProduct(action: .reload)
        }
        
        tableView.cr.addFootRefresh { [weak self] in
            self?.viewModel.fetchProduct(action: .loadMore)
        }
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        showSearchBar.accept(())
    }
}

extension ProductViewController {
    
    private func addObservers() {
        viewModel.products
            .asObservable()
            .bind(to: tableView
                .rx
                .items(cellIdentifier: ProductCell.identifier, cellType: ProductCell.self)) { _, product, cell in
            cell.configCell(product)
        }.disposed(by: disposeBag)

        viewModel.errorsTracker.bind(to: errorBinder).disposed(by: disposeBag)
        viewModel.reloadingActivity.bind(to: endReloadingHUDBinder).disposed(by: disposeBag)
        viewModel.loadingMoreActivity.bind(to: endLoadingMoreBinder).disposed(by: disposeBag)
    }
    
    private var endReloadingHUDBinder: Binder<Bool> {
        return Binder(self) { (target, isReloading) in
            if !isReloading {
                target.tableView.cr.endHeaderRefresh()
            }
        }
    }
    
    private var endLoadingMoreBinder: Binder<Bool> {
        return Binder(self) { (target, isReloading) in
            if !isReloading {
                target.tableView.cr.endLoadingMore()
            }
        }
    }
    
    private var errorBinder: Binder<DomainError> {
        return Binder(self) { (target, error) in
            AlertView.shared.presentSimpleAlert(title: "Error", message: error.localizedDescription)
        }
    }
}
