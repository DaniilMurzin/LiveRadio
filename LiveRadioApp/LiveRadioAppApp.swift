//
//  LiveRadioAppApp.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 02.09.2024.
//

import SwiftUI

@main
struct LiveRadioAppApp: App {
    
    let coordinator: RootCoordinator
    
    init() {
        coordinator = FRoot.makeRootCoordinator()
    }
    
    var body: some Scene {
        WindowGroup {
            RootCoordinatorView()
                .environmentObject(coordinator)
                .onAppear(perform: coordinator.showOnboarding)
        }
    }
}
