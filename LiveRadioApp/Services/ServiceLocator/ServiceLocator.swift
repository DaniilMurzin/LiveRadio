//
//  ServiceLocator.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 31.10.2025.
//

import Foundation

protocol Dependency { init() }

final class ServiceLocator {
    
    private var dependencies = [AnyHashable: Dependency]()
    
    func register<T: Dependency> (_ type: T.Type) {
        dependencies[String(describing: type.self)] = T()
    }
#warning("default: T() не записывается в словарь")
    func resolveDefault<T: Dependency>(_ type: T.Type) -> T {
        dependencies[String(describing: type.self), default: T()] as! T
    }

    func resolve<T: Dependency>(_ type: T.Type) -> T {
        let key = String(describing: type)
        guard let service = dependencies[key] as? T else {
            let newService = T()
            dependencies[key] = newService
            return newService
        }
        return service
    }
    
//    func resolve<T: Dependency>(_ type: T.Type) -> T {
//        let key = String(describing: type)
//        if let service = dependencies[key] as? T { return service }
//        let new = T()
//        dependencies[key] = new
//        return new
//    }
}
