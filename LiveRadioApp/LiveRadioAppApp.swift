//
//  LiveRadioAppApp.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 02.09.2024.
//

import SwiftUI
import Firebase

@main
struct LiveRadioAppApp: App {
    let coordinator: RootCoordinator
    
    init() {
        coordinator = FRoot.makeRootCoordinator()
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            RootCoordinatorView(factory: coordinator.factory)
                .environmentObject(coordinator)
                .onAppear(perform: coordinator.showOnboarding)
        }
    }
}
