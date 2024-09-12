//
//  Station.swift
//  LiveRadioApp
//
//  Created by Шаповалов Илья on 30.08.2024.
//

import Foundation

struct Station: Hashable {
    
    let title: String
    
    static let preview = [
        Self(title: "Station n1"),
        Self(title: "Station n2"),
        Self(title: "Station n3")
    ]
}
