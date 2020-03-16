//
//  UITableView+.swift
//  ProductDiscovery
//
//  Created by Anh Tran on 3/16/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import UIKit

extension UITableView {
    
    func dequeueReusableCell<T>(ofType type: T.Type, for indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as? T
    }
}
