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
            stations: Station.mockList,
            volume: $viewModel.volume,
            name: $viewModel.name,
            isPlaying: $viewModel.isPlaying,
            isSelected: $viewModel.isFavorite)
    }
}
