//
//  UICollectionView+.swift
//  ProductDiscovery
//
//  Created by Anh Tran on 3/16/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCell<T>(ofType type: T.Type, for indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withReuseIdentifier: String(describing: type), for: indexPath) as? T
    }
}
