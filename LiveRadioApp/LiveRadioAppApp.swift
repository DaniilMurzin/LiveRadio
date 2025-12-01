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
    let rootCoordinator: RootCoordinator
    
    init() {
        FirebaseApp.configure()
        rootCoordinator = AppFactory.makeRootCoordinator()
    }
    
    var body: some Scene {
        WindowGroup {
#warning("Зачем доставать фабрику из координатора для использования в координатор вью?")
            RootCoordinatorView(factory: rootCoordinator.factory)
                .environmentObject(rootCoordinator)
                .onAppear(perform: rootCoordinator.showAuthorization)
        }
    }
}
