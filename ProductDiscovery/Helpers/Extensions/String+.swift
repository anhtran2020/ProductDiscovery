//
//  String+.swift
//  ProductDiscovery
//
//  Created by David Tran on 3/16/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

extension String {
    
    var strikethroughStyleAttributed : NSAttributedString {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        
        return attributeString
    }
}
