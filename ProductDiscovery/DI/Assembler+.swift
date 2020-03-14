//
//  Assembler+.swift
//  ProductDiscovery
//
//  Created by Anh Tran on 3/12/20.
//  Copyright © 2020 David Tran. All rights reserved.
//

import Swinject

extension Assembler {
    static let shared: Assembler = {
        let container = Container()
        let assembler = Assembler([NetworkAssembly(),
                                   ViewModelAssembly(),
                                   ViewControllerAssembly()],
                                  container: container)
        return assembler
    }()
    
    static func resolve<T>(_ serviceType: T.Type) -> T? {
        return Assembler.shared.resolver.resolve(serviceType)
    }
    
    static func resolve<T, Arg1>(_ serviceType: T.Type, argument: Arg1) -> T? {
        return Assembler.shared.resolver.resolve(serviceType, argument: argument)
    }
}
