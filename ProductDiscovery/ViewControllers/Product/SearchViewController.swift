//
//  SearchProductViewController.swift
//  ProductDiscovery
//
//  Created by David Tran on 3/13/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import UIKit
import Domain
import RxSwift
import RxCocoa
import CRRefresh

class SearchViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    
    var viewModel: SearchViewModel!
    
    var backAction = PublishRelay<Void>()
    var showDetailAction = PublishRelay<Product>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addObservers()
    }

    private func setupViews() {
        dimBackgroundColor()
        searchBar.becomeFirstResponder()
        tableView.backgroundView = UIControl()
        headerViewHeightConstraint.constant = HeaderViewConstant.height + view.windowSafeAreaInsets.top
        
        tableView.cr.addFootRefresh { [weak self] in
            self?.loadMore()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    private func addObservers() {
        searchBar.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(to: searchBinder)
            .disposed(by: disposeBag)
        
        viewModel.products
            .asObservable()
            .bind(to: tableView
                .rx
                .items(cellIdentifier: ProductCell.identifier, cellType: ProductCell.self)) { _, product, cell in
            cell.configCell(product)
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Product.self).bind(to: showDetailAction).disposed(by: disposeBag)
        viewModel.errorsTracker.bind(to: errorBinder).disposed(by: disposeBag)
        viewModel.loadingMoreActivity.bind(to: endLoadingMoreBinder).disposed(by: disposeBag)
        (tableView.backgroundView as? UIControl)?.rx.controlEvent(.touchUpInside).bind(to: tapBackgroundBinder).disposed(by: disposeBag)
    }
    
    private func loadMore() {
        let query = searchBar.text ?? ""
        viewModel.search(with: query, action: .loadMore)
    }
    
    @objc private func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            tableViewBottomConstraint.constant = 0
        } else {
            tableViewBottomConstraint.constant = keyboardViewEndFrame.height - view.safeAreaInsets.bottom
        }
    }
    
    private func dimBackgroundColor() {
        view.backgroundColor = searchBar.text?.isEmpty == true ? UIColor.black.withAlphaComponent(0.3) : .white
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        backAction.accept(())
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        searchBar.resignFirstResponder()
    }
}

extension SearchViewController {
    
    private var tapBackgroundBinder: Binder<Void> {
        return Binder(self) { (target, _) in
            target.searchBar.resignFirstResponder()
            target.backAction.accept(())
        }
    }
    
    private var searchBinder: Binder<String> {
        return Binder(self) { (target, query) in
            target.dimBackgroundColor()
            target.viewModel.search(with: query, action: .reload)
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
