//
//  AllStationsContentView.swift
//  RadioApp
//
//  Created by Daniil Murzin on 12.02.2025.
//

import SwiftUI

struct AllStationsContentView: View {
    
    @StateObject var viewModel: AllStationsViewModel
    
    init(_ viewModel: AllStationsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        AllStationsView(
            stations: [],
            name: "Daniil",
            volume: $viewModel.volume,
            selectedStation: $viewModel.selectedStation,
            isPlaying: viewModel.isPlaying,
            didTapbackButton: {},
            didTapPlayButton: {},
            didTapBackwardButton: {},
            didTapForwardButton: {},
            didTapCell: {_ in },
            didTapFavoriteButton: {_ in },
            searchFieldText: $viewModel.searchText)
    }
}
