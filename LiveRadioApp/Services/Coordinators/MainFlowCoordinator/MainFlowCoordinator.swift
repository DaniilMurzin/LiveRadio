//
//  MainFlowCoordinator.swift
//  RadioApp
//
//  Created by Daniil Murzin on 07.11.2025.
//

import SwiftUI

final class MainFlowCoordinator: ObservableObject {
    
    let factory: MainFlowFactory
    @Published var state: Tab
    
    init(factory: MainFlowFactory, state: Tab = .popular) {
        self.factory = factory
        self.state = state
    }
    
    func makeContent(for tab: Tab) -> AnyView {
          switch tab {
          case .popular:
              return AnyView(factory.makePopular())
          case .favorites:
              return AnyView(factory.makeFavorites())
          case .allStations:
              return AnyView(factory.makeAllStations())
          }
      }
    
    func goToTab(_ tab: Tab) {
           state = tab
       }
}
