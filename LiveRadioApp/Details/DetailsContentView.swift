//
//  DetailsContentView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 18.09.2024.
//

import SwiftUI

struct DetailsContentView: View {
    
    @StateObject var viewModel: DetailsViewModel
    @EnvironmentObject var coordinator: RootCoordinator
    
    init(_ viewModel: DetailsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    //TODO: Убрать таб бар
    var body: some View {
        DetailsView(localization: .develop,
                    didTapbackButton: coordinator.showTabBar,
                    didTapBackwardButton: viewModel.didTapBackwardButton,
                    didTapForwardButton: viewModel.didTapForwardButton,
                    didTapPlayButton: viewModel.didTapPlayButton
                    )
    }
    
}
