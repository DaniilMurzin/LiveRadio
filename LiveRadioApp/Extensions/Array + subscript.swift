//
//  Array.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 30.12.2024.
//

extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
