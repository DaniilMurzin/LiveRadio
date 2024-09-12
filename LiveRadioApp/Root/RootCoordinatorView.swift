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
        // Презентация, анимации
        switch coordinator.state {
        case .loading:
            ProgressView()
            
        case .error:
            EmptyView()
            
        case .onboarding:
            factory.makeOnboarding()
            
        case .authorization:
            factory.makeAuthorization()
            
        case .tabbar:
            EmptyView()
        }
    }
}
