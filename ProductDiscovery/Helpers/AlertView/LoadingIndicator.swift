//
//  LoadingIndicator.swift
//  ProductDiscovery
//
//  Created by David Tran on 3/17/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import UIKit
import MBProgressHUD

class LoadingIndicator {
    static let shared = LoadingIndicator()
    
    func showAdd(to view: UIView, animated: Bool = true) {
        MBProgressHUD.showAdded(to: view, animated: animated)
    }
    
    func hide(for view: UIView, animated: Bool = true) {
        MBProgressHUD.hide(for: view, animated: true)
    }
}
