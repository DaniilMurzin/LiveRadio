//
//  TabBarContentView.swift
//  RadioApp
//
//  Created by Daniil Murzin on 04.11.2025.
//
import SwiftUI

struct TabBarContentView: View {
    @StateObject var viewModel: TabBarViewModel
    
    init(_ vm: TabBarViewModel) {
        _viewModel = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        TabBarView(
            isPlaying: viewModel.isPlaying,
            didTapPlayButton: viewModel.didTapPlayButton,
            didTapBackwardButton: viewModel.playPreviousStation,
            didTapForwardButton: viewModel.playNextStation,
            didTapProfileButton: {},
            name: viewModel.user.name,
            selected: $viewModel.selectedTab
        ) { tab in
            viewModel.coordinator.makeContent(for: tab)
        }
    }
}
