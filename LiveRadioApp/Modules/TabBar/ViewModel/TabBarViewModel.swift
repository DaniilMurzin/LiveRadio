//
//  TabBarViewModel.swift
//  RadioApp
//
//  Created by Daniil Murzin on 04.11.2025.
//

import SwiftUI

final class TabBarViewModel: ObservableObject {
    
    @Published var selectedTab: Tab = .popular
    @Published private(set) var user: LocalUser
    
    private let avPlayer: RadioPlayer
    let coordinator: MainFlowCoordinator

    var isPlaying: Binding<Bool> {
        Binding (
            get: { self.avPlayer.isPlaying },
            set: { self.avPlayer.isPlaying = $0
                self.objectWillChange.send()
            }
        )
    }
    
    init(
        user: LocalUser,
        avPlayer: RadioPlayer,
        coordinator: MainFlowCoordinator
    ) {
        self.user = user
        self.avPlayer = avPlayer
        self.coordinator = coordinator
    }
    
    func didSelect(tab: Tab) {
        selectedTab = tab
        coordinator.goToTab(tab)
    }
    
    func didTapPlayButton() {
          guard avPlayer.currentStation != nil else { return }
          avPlayer.isPlaying.toggle()
      }
      
      func playNextStation() {
          avPlayer.playNext()
      }
      
      func playPreviousStation() {
          avPlayer.playPrevious()
      }
}
