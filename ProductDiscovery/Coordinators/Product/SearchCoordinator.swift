//
//  SearchCoordinator.swift
//  ProductDiscovery
//
//  Created by David Tran on 3/14/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import UIKit
import Swinject
import RxSwift
import RxCocoa

class SearchCoordinator: BaseCoordinator {
    
    var presenter: UINavigationController?
    
    init(presenter: UINavigationController?) {
        self.presenter = presenter
    }

    override func start() {
        guard let searchVC = Assembler.resolve(SearchViewController.self) else {
            return
        }
        
        let navigationController = BaseNavigationController(rootViewController: searchVC)
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.providesPresentationContextTransitionStyle = true
        navigationController.modalPresentationStyle = .overFullScreen
        navigationController.modalTransitionStyle = .crossDissolve
        presenter?.present(navigationController, animated: true, completion: nil)
        
        searchVC.backAction.bind(to: backActionBinder).disposed(by: disposeBag)
    }
}

extension SearchCoordinator {
    
    var backActionBinder: Binder<Void> {
        return Binder(self) { (target, _) in
            target.presenter?.dismiss(animated: true, completion: nil)
            target.isCompleted?()
        }
    }
}
