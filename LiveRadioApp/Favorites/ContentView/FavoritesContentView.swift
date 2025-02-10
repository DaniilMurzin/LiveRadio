//
//  FavoritesContentView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 23.12.2024.
//

import SwiftUI

struct FavoritesContentView: View  {
   
    @StateObject var viewModel: FavoritesViewModel
    
    init(_ viewModel: FavoritesViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        FavoritesView(
            stations: viewModel.fetchedStations,
            name: viewModel.name,
            volume: $viewModel.volume,
            selectedStation: $viewModel.selectedStation,
            isPlaying: $viewModel.avPlayer.isPlaying,
            didTapbackButton: viewModel.playPreviousStation,
            didTapPlayButton: viewModel.didTapPlayButton,
            didTapBackwardButton: viewModel.playPreviousStation ,
            didTapForwardButton: viewModel.playNextStation ,
            didTapCell: viewModel.handleSelection,
            didTapFavoriteButton: viewModel.toggleFavorite
        )
        .task { await viewModel.fetchFavoriteStations() }
        .onAppear(perform: viewModel.onAppear)
    }
}
