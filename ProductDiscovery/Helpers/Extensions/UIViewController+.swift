//
//  UIViewController+.swift
//  ProductDiscovery
//
//  Created by Anh Tran on 3/12/20.
//  Copyright © 2020 David Tran. All rights reserved.
//

import UIKit

enum StoryboardName: String {
    case product = "Product"
}

extension UIViewController {
    
    func topController(controller: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController {
        if let navigationController = controller as? UINavigationController {
            return topController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topController(controller: presented)
        }
        return controller ?? UIViewController()
    }
}

extension UIViewController {
    
    func instantiateViewController<T>(fromStoryboard name: StoryboardName, ofType type: T.Type) -> T {
        return UIStoryboard(name: name.rawValue, bundle: nil).instantiateViewController(ofType: type)
    }
}

extension UIViewController {
    
    static func instantiateViewController<T>(fromStoryboard name: StoryboardName, ofType type: T.Type) -> T {
        return UIStoryboard(name: name.rawValue, bundle: nil).instantiateViewController(ofType: type)
    }
}
