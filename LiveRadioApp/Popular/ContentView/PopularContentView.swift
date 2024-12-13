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
    #warning("Обращаюсь к avPlayer через viewModel?")
    var body: some View {
        PopularView(
            name: $viewModel.name,
            volume: $viewModel.volume,
            selectedStation: $viewModel.selectedStation,
            didTapbackButton: { viewModel.avPlayer.playPreviousStation() },
            didTapPlayButton: { viewModel.avPlayer.isPlaying ? viewModel.avPlayer.pauseStation() : viewModel.avPlayer.resumeStation() },
            didTapBackwardButton: { viewModel.avPlayer.playPreviousStation() },
            didTapForwardButton: { viewModel.avPlayer.playNextStation() },
            didTapCell: { station in
                viewModel.handleSelection(station)
            },
            stations: viewModel.fetchedStations
        )
        .onAppear {
            viewModel.fetchPopularStations()
        }
    }
}

