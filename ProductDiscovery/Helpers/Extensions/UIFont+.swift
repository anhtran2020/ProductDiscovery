//
//  UIFont+.swift
//  ProductDiscovery
//
//  Created by Anh Tran on 3/16/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import UIKit

extension UIFont {

    static func semiBoldDesignFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "SFProText-Semibold", size: size)!
    }
    
    static func mediumDesignFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "SFProText-Medium", size: size)!
    }
    
    static func regularDesignFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "SFProText-Regular", size: size)!
    }
}
