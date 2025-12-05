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
            stations: viewModel.fetchedStations,
            name: "Daniil",
            volume: $viewModel.volume,
            selectedStation: $viewModel.selectedStation,
            isPlaying: viewModel.isPlaying,
            searchFieldText: $viewModel.searchText,
            didTapCell: viewModel.handleSelection,
            didTapFavoriteButton: viewModel.toggleFavorite
        )

        .onAppear(perform: viewModel.onAppear)
        .onChange(of: viewModel.searchText) { newValue in
            Task {
                if !newValue.isEmpty && newValue.count > 2 {
                    await viewModel.searchByName()
                }
            }
        }
    }
}
