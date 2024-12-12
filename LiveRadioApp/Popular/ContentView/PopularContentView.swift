//
//  PopularContentView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 30.08.2024.
//

import SwiftUI

struct PopularContentView: View {
    
    //MARK: - Properties
    @StateObject var viewModel: PopularViewModel
    
    //MARK: - init(_:)
    init(_ viewModel: PopularViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    //MARK: - body
    var body: some View {
        PopularView(
            name: $viewModel.name,
            volume: $viewModel.volume,
            didTapbackButton: {},
            didTapBackwardButton: {},
            didTapForwardButton: {},
            didTapCell: { station in
                viewModel.play(station: station)
            },
            stations: viewModel.fetchedStations
        )
        .onAppear {
            viewModel.fetchPopularStations()
        }
    }
}
