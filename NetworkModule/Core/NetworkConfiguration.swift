//
//  NetworkConfiguration.swift
//  NetworkModule
//
//  Created by David Tran on 3/13/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

public class NetworkConfiguration {
    let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
}
