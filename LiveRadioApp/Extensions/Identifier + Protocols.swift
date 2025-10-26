//
//  Identifier + Protocols.swift
//  RadioApp
//
//  Created by Daniil Murzin on 05.10.2025.
//

import Foundation

struct Identifier<Root, RawValue> {
    let rawValue: RawValue
    init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
}

let ad = Identifier<String, String>(rawValue: "ad")

extension Identifier: Equatable where RawValue: Equatable {}
extension Identifier: Hashable where RawValue: Hashable {}
extension Identifier: Sendable where RawValue: Sendable {}
extension Identifier: CustomStringConvertible where RawValue: CustomStringConvertible {
    var description: String { rawValue.description }
}
extension Identifier: Codable where RawValue: Codable {}
