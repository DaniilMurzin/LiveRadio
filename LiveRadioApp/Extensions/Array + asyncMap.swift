//
//  Array + asyncMap.swift
//  RadioApp
//
//  Created by Daniil Murzin on 03.02.2025.
//

extension Array {
    public func asyncMap<T>(_ transform: (Element) async throws -> T) async throws -> [T] {
        var results: [T] = []
        for element in self {
            results.append(try await transform(element))
        }
        return results
    }
}
