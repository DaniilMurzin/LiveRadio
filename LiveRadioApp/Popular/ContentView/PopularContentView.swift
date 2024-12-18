//
//  PopularContentView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 30.08.2024.
//

import SwiftUI

struct PopularContentView: View {
    @StateObject var viewModel: PopularViewModel
    
    init(_ viewModel: PopularViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        PopularView(
            name: $viewModel.name,
            volume: $viewModel.volume,
            selectedStation: $viewModel.selectedStation,
            isPlaying: $viewModel.avPlayer.isPlaying,
//            amplitude: $viewModel.avPlayer.amplitude,
            didTapbackButton: { viewModel.playPreviousStation() },
            didTapPlayButton: {
                viewModel.avPlayer.isPlaying ?
                viewModel.avPlayer.pauseStation() :
                viewModel.avPlayer.resumeStation()
            },
            didTapBackwardButton: { viewModel.playPreviousStation() },
            didTapForwardButton: { viewModel.playNextStation() },
            didTapCell: { station in viewModel.handleSelection(station)},
            stations: viewModel.fetchedStations
        )
        .onAppear {
            viewModel.fetchPopularStations()
        }
    }
}
