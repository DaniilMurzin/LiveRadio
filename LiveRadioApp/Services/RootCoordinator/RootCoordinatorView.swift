//
//  RootCoordinatorView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 30.08.2024.
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
            
            case .error:
                Text("Ошибка")
                    .transition(.slide)
            
            case .onboarding:
                factory.makeOnboarding()
                
            case .authorization:
                factory.makeAuthorization(coordinator: coordinator)
            
            case .tabbar:
                factory.makeTabBar()
                
            case .details:
                factory.makeDetails()
            }
        }
    }
}

