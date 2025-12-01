////
////  MainFlowCoordinatorView.swift
////  LiveRadioApp
////
////  Created by Daniil Murzin on 07.11.2025.
////
//
//import SwiftUI
//
//struct MainFlowCoordinatorView: View {
//    
//    @EnvironmentObject var coordinator: MainFlowCoordinator
//    
//    let factory: MainFlowFactory
//    
//    init(factory: AppFactory) {
//        self.factory = factory
//    }
//    
//    var body: some View {
//        ZStack {
//            switch coordinator.state {
//            case .favorites:
//                AnyView(factory.makeFavorites())
//            case .allStations:
//                AnyView(factory.makeAllStations())
//            case .popular:
//                AnyView(factory.makePopular())
//            }
//        }
//    }
//}
