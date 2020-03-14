//
//  BaseCoordinator.swift
//  ProductDiscovery
//
//  Created by David Tran on 3/14/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import UIKit
import RxSwift

class BaseCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var isCompleted: (() -> ())?
    let disposeBag = DisposeBag()
    
    func start() {
        
    }
    
    func handleStore(coordinator: BaseCoordinator) {
        store(coordinator: coordinator)
        coordinator.isCompleted = { [weak self] in
            self?.free(coordinator: coordinator)
        }
    }
}
