//
//  Config.swift
//  NetworkModule
//
//  Created by David Tran on 3/13/20.
//  Copyright © 2020 Teko. All rights reserved.
//

#if PRODUCTION
let baseURL = URL(string: "https://listing.stage.tekoapis.net/")!
#elseif DEVELOPMENT
let baseURL = URL(string: "https://listing.stage.tekoapis.net/")!
#else
let baseURL = URL(string: "https://listing.stage.tekoapis.net/")!
#endif
