//
//  RootCoordinatorView.swift
//  LiveRadioApp
//
//  Created by Шаповалов Илья on 30.08.2024.
//

import SwiftUI

struct RootCoordinatorView: View {
    @EnvironmentObject var coordinator: RootCoordinator
    
    var body: some View {
        // Презентация, анимации
        switch coordinator.state {
        case .loading:
            ProgressView()
            
        case .error:
            EmptyView()
            
        case let .onboarding(viewModel):
            OnboardingContentView(viewModel)
            
        case let .authorization(viewModel):
            AuthorizationContentView(viewModel)
            
        case .tabbar:
            EmptyView()
        }
    }
}
