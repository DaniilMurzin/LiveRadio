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
    #warning("DidTapPlayButton")
    var body: some View {
        PopularView(
            name: viewModel.name,
            volume: $viewModel.volume,
            selectedStation: $viewModel.selectedStation,
            isPlaying: $viewModel.avPlayer.isPlaying,
            didTapbackButton: viewModel.playPreviousStation,
            // TODO: вынести в отдельный метод 
            didTapPlayButton: {
                if let selectedStation = viewModel.selectedStation {
                    viewModel.handleSelection(selectedStation)
                }
            },
            didTapBackwardButton: viewModel.playPreviousStation ,
            didTapForwardButton: viewModel.playNextStation ,
            didTapCell: viewModel.handleSelection,
            didTapFavoriteButton: viewModel.toggleFavorite,
            stations: viewModel.fetchedStations
        )
        .task(viewModel.fetchPopularStations)
        .onAppear(perform: viewModel.onAppear)
    }
}
