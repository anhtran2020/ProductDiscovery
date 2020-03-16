//
//  Double+.swift
//  ProductDiscovery
//
//  Created by David Tran on 3/13/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

extension Double {
    
    var formattedWithDots: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
    
    var formattedWithDotsAndDefaultUnit: String {
        return self.formattedWithDots + " đ"
    }
}
