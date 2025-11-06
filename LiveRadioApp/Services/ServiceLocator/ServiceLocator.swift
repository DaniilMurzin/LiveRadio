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
    
    func resolve<T: Dependency>(_ type: T.Type) -> T {
        let key = String(describing: type)
        guard let service = dependencies[key] as? T else {
            let newService = T()
            dependencies[key] = newService
            return newService
        }
        return service
    }
}
