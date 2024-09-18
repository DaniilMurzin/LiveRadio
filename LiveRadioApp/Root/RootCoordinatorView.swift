//
//  RootCoordinatorView.swift
//  LiveRadioApp
//
//  Created by Шаповалов Илья on 30.08.2024.
//

import SwiftUI

struct RootCoordinatorView: View {
    @EnvironmentObject var coordinator: RootCoordinator
    let factory: RootFactory
    
    init(factory: RootFactory) {
        self.factory = factory
    }
    
    var body: some View {
        ZStack {
            switch coordinator.state {
            case .loading:
                ProgressView()
                    .transition(.opacity)
            
            case .error:
                Text("Ошибка")
                    .transition(.slide)
            
            case .onboarding:
                factory.makeOnboarding()
    
                    .transition(.move(edge: .leading))
            case .authorization:
                factory.makeAuthorization()
                    .transition(.move(edge: .leading))
            
            case .tabbar:
                factory.makeTabBar()
                    .transition(.move(edge: .leading))
            case .details:
                factory.makeDetails()
                    .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut, value: coordinator.state)
    }
}

