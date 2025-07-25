//
//  Button+AsyncAction.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 05.10.2024.
//

import SwiftUI

extension Button {
    init(
        asyncAction: @escaping () async throws -> Sendable,
        @ViewBuilder label: () -> Label
    ) {
        self.init(
            action: { Task(operation: asyncAction) },
            label: label
        )
    }
}
